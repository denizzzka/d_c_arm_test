module external.core.thread;

import core.thread.osthread;
import core.thread.threadbase;
import core.thread.types: ThreadID;
import core.thread.context: StackContext;
static import os = freertos;

extern(C) void thread_entryPoint(void* arg) nothrow
in(arg)
{
    auto obj = cast(Thread) arg;

    obj.initDataStorage();
    Thread.setThis(obj);
    ThreadBase.add(obj);

    scope (exit)
    {
        ThreadBase.remove(obj);
        obj.destroyDataStorage();
    }

    Thread.add(&obj.m_main);

    void append(Throwable t)
    {
        obj.m_unhandled = Throwable.chainTogether(obj.m_unhandled, t);
    }

    try
    {
        rt_moduleTlsCtor();

        try
            obj.run();
        catch (Throwable t)
            append( t );

        rt_moduleTlsDtor();
    }
    catch (Throwable t)
        append( t );
}

@nogc:

/// Init threads module
extern (C) void thread_init() @nogc
{
    initLowlevelThreads();
    ThreadBase.initLocks();

    // Threads storage
    assert(typeid(Thread).initializer.ptr);
    _mainThreadStore[] = typeid(Thread).initializer[];

    import external.rt.dmain: mainTaskProperties;
    Thread.stackBottom = mainTaskProperties.stackBottom;

    // Creating main thread
    ThreadBase.sm_main = external_attachThread((cast(Thread)_mainThreadStore.ptr).__ctor());
}

/// Term threads module
extern (C) void thread_term() @nogc
{
    thread_term_tpl!(Thread)(_mainThreadStore);
}

nothrow:

extern (C) static Thread thread_findByAddr(ThreadID addr)
{
    assert(false, "Not implemented");
}

extern (C) void thread_suspendHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_resumeHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

/// Suspend all threads but the calling thread
extern (C) void thread_suspendAll() nothrow
{
    if ( !multiThreadedFlag && Thread.sm_tbeg )
    {
        if ( ++suspendDepth == 1 )
            suspend( Thread.getThis() );

        return;
    }

    ThreadBase.slock.lock_nothrow();

    {
        if ( ++suspendDepth > 1 )
            return;

        ThreadBase.criticalRegionLock.lock_nothrow();
        scope (exit) ThreadBase.criticalRegionLock.unlock_nothrow();

        size_t cnt;
        Thread t = ThreadBase.sm_tbeg.toThread;

        while (t)
        {
            auto tn = t.next.toThread;
            if (suspend(t))
                ++cnt;
            t = tn;
        }

        assert(cnt >= 1);
    }
}

/// Suspend the specified thread and load stack and register information
private extern (D) bool suspend( Thread t ) nothrow
{
    // Common code (TODO: use druntime code instead?):
    import core.time;

    Duration waittime = dur!"usecs"(10);

 Lagain:
    if (!t.isRunning)
    {
        Thread.remove(t);
        return false;
    }
    else if (t.m_isInCriticalRegion)
    {
        ThreadBase.criticalRegionLock.unlock_nothrow();
        Thread.sleep(waittime);
        if (waittime < dur!"msecs"(10)) waittime *= 2;
        ThreadBase.criticalRegionLock.lock_nothrow();
        goto Lagain;
    }

    // OS-specific code:

    if (t.m_addr != os.xTaskGetCurrentTaskHandle())
    {
        os.vTaskSuspend(t.m_addr);
    }
    else if (!t.m_lock)
    {
        t.m_curr.tstack = getStackTop();
    }

    return true;
}

void thread_intermediateShutdown() nothrow @nogc
{
    assert(false, "Not implemented");
}

public void* getStackTop() nothrow @nogc
{
    import ldc.intrinsics;
    pragma(LDC_never_inline);
    return llvm_frameaddress(0);
}

void* getStackBottom() nothrow @nogc
{
    assert(Thread.stackBottom !is null);

    return Thread.stackBottom;
}

ThreadID createLowLevelThread(void delegate() nothrow dg, uint stacksize = 0,
                              void delegate() nothrow cbDllUnload = null) nothrow @nogc
{
    assert(false, "Not implemented");
}

bool findLowLevelThread(ThreadID tid) nothrow @nogc
{
    assert(false, "Not implemented");
}

//TODO: this is only for internal use, rename it to more appropriate?
Thread external_attachThread(ThreadBase thisThread) @nogc
{
    Thread t = thisThread.toThread;

    StackContext* thisContext = &thisThread.m_main;
    assert(thisContext);
    assert(thisContext == t.m_curr);

    t.m_addr = os.xTaskGetCurrentTaskHandle();
    thisContext.bstack = getStackBottom();
    thisContext.tstack = thisContext.bstack;

    t.m_isDaemon = true;
    t.tlsGCdataInit();
    Thread.setThis(t);

    ThreadBase.add( t, false );
    ThreadBase.add( thisContext );
    if ( Thread.sm_main !is null )
        multiThreadedFlag = true;

    return t;
}

class Thread : ThreadBase
{
    import core.sync.event: Event;

    private static void* stackBottom;
    private static Event joinEvent;

    static this()
    {
        joinEvent = Event(true, true);
    }

    /// Initializes a thread object which has no associated executable function.
    /// This is used for the main thread initialized in thread_init().
    private this(size_t sz = 0) @safe pure nothrow @nogc
    {
    }

    this(void function() fn, size_t sz = 0) @safe pure nothrow @nogc
    in(fn !is null)
    {
        super(fn, sz);
    }

    this(void delegate() dg, size_t sz = 0) @safe pure nothrow @nogc
    in(dg !is null)
    {
        super(dg, sz);
    }

    ~this() nothrow @nogc
    {
        assert(false);
    }

    override final void run()
    {
        super.run();
    }

    final Thread start() nothrow
    {
        auto wasThreaded  = multiThreadedFlag;
        multiThreadedFlag = true;
        scope( failure )
        {
            if ( !wasThreaded )
                multiThreadedFlag = false;
        }

        slock.lock_nothrow();
        scope(exit) slock.unlock_nothrow();

        {
            import core.stdc.stdlib: realloc;
            import external.rt.sections: aligned_alloc;

            ++nAboutToStart;
            pAboutToStart = cast(ThreadBase*)realloc(pAboutToStart, Thread.sizeof * nAboutToStart);
            pAboutToStart[nAboutToStart - 1] = this;

            if(m_sz == 0)
                m_sz = 256 * size_t.sizeof; // assumed default stack size

            assert(m_sz <= ushort.max * size_t.sizeof, "FreeRTOS stack size limit");

            auto wordsStackSize = m_sz / os.StackType_t.sizeof
                + (m_sz % os.StackType_t.sizeof ? 1 : 0);

            //FIXME: add error checking
            auto tcb = cast(os.StaticTask_t*) aligned_alloc(size_t.sizeof, os.StaticTask_t.sizeof);
            stackBottom = aligned_alloc(os.StackType_t.sizeof, os.StackType_t.sizeof * wordsStackSize);

            assert(tcb);
            assert(stackBottom);

            *tcb = os.StaticTask_t();

            m_addr = os.xTaskCreateStatic(
                &thread_entryPoint,
                cast(const(char*)) "D thread",
                wordsStackSize,
                cast(void*) this, // pvParameters*
                5, // uxPriority
                cast(size_t*) stackBottom,
                tcb
            );

            return this;
        }
    }

    static Thread getThis() @safe nothrow @nogc
    {
        return cast(Thread) ThreadBase.getThis;
    }

    override final @property bool isRunning() nothrow @nogc
    {
        //FIXME: Not implemented
        return true;
    }

    //
    // Remove a thread from the global thread list.
    //
    static void remove(Thread t) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    override final Throwable join( bool rethrow = true )
    {
        joinEvent.wait();

        m_addr = m_addr.init;

        if (m_unhandled)
        {
            if (rethrow)
                throw m_unhandled;
            return m_unhandled;
        }

        return null;
    }

    final void joinAll( bool rethrow = true )
    {
        assert(false, "Not implemented");
    }

    import core.time: Duration;

    static void sleep( Duration val ) @nogc nothrow
    {
        assert(false, "Not implemented");
    }

    static void yield() @nogc nothrow
    {
        assert(false, "Not implemented");
    }

    static int opApply(scope int delegate(ref Thread) dg)
    {
        assert(false, "Not implemented");
    }
}

private Thread toThread(ThreadBase t) @trusted nothrow @nogc pure
{
    return cast(Thread) cast(void*) t;
}
