module external.core.thread;

import core.thread.osthread;
import core.thread.threadbase;
import core.thread.types: ThreadID;
import core.thread.context: StackContext;
static import freertos;

@nogc:

/// Init threads module
extern (C) void thread_init() @nogc
{
    initLowlevelThreads();
    ThreadBase.initLocks();

    // Threads storage
    assert(typeid(Thread).initializer.ptr);
    _mainThreadStore[] = typeid(Thread).initializer[];

    // Creating main thread
    Thread.sm_main = external_attachThread((cast(Thread)_mainThreadStore.ptr).__ctor());
}

nothrow:

/// Term threads module
extern (C) void thread_term() @nogc
{
    assert(false, "Not implemented");
}

extern (C) static Thread thread_findByAddr(ThreadID addr)
{
    assert(false, "Not implemented");
}

extern (C) void* thread_entryPoint( void* arg ) nothrow
{
    Thread obj = cast(Thread) arg;
    Thread.setThis(obj);

    obj.tlsGCdataInit();

    //FIXME: osthread.d contains more stuff here

    return null;
}

extern (C) void thread_suspendHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_resumeHandler( int sig ) nothrow
{
    assert(false, "Not implemented");
}

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

        version (Darwin)
        {}
        else version (Posix)
        {
            // subtract own thread
            assert(cnt >= 1);
            --cnt;
        Lagain:
            // wait for semaphore notifications
            for (; cnt; --cnt)
            {
                while (sem_wait(&suspendCount) != 0)
                {
                    if (errno != EINTR)
                        onThreadError("Unable to wait for semaphore");
                    errno = 0;
                }
            }
        }
    }
}

/// Suspend the specified thread and load stack and register information
private extern (D) bool suspend( Thread t ) nothrow
{
    // Common code (TODO: use druntime code instead):
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

    if (t.m_addr != freertos.xTaskGetCurrentTaskHandle())
    {
        freertos.vTaskSuspend(t.m_addr);
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

private void* getStackTop() nothrow @nogc
{
    import ldc.intrinsics;
    pragma(LDC_never_inline);
    return llvm_frameaddress(0);
}

void* getStackBottom() nothrow @nogc
{
    assert(false, "Not implemented");
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

Thread external_attachThread(ThreadBase thisThread) @nogc
{
    Thread t = thisThread.toThread;

    Thread.setThis(t);

    t.tlsGCdataInit();

    return t;
}

class Thread : ThreadBase
{
    /// Main process thread
    private __gshared Thread sm_main;

    /// Current thread
    private static Thread sm_this;

    bool m_isInCriticalRegion;

    /// Initializes a thread object which has no associated executable function.
    /// This is used for the main thread initialized in thread_init().
    private this(size_t sz = 0) @safe pure nothrow @nogc
    {
    }

    this(void function() fn, size_t sz = 0) @safe pure nothrow @nogc
    in(fn !is null)
    {
        assert(false, "Not implemented");
    }

    this(void delegate() dg, size_t sz = 0) @safe pure nothrow @nogc
    in(dg !is null)
    {
        assert(false, "Not implemented");
    }

    final Thread start() nothrow
    {
        assert(false, "Not implemented");
    }

    /// Sets a thread-local reference to the current thread object.
    static void setThis(Thread t) nothrow @nogc
    {
        sm_this = t;
    }

    static Thread getThis() @safe nothrow @nogc
    {
        return sm_this;
    }

    override final @property bool isRunning() nothrow @nogc
    {
        if (!super.isRunning())
            return false;

        assert(false, "Not implemented");
    }

    static void add(StackContext* c) nothrow @nogc
    in( c )
    {
        assert(false, "Not implemented");
    }

    //
    // Remove a thread from the global thread list.
    //
    static void remove(Thread t) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    static void remove(StackContext* c) nothrow @nogc
    in( c )
    {
        assert(false, "Not implemented");
    }

    override final Throwable join( bool rethrow = true )
    {
        assert(false, "Not implemented");
    }

    final void joinAll( bool rethrow = true )
    {
        assert(false, "Not implemented");
    }

    import core.time: Duration;

    static void sleep( Duration val ) @nogc nothrow
    {
        //~ assert(false, "Not implemented");
    }

    static void yield() @nogc nothrow
    {
        //~ assert(false, "Not implemented"); //FIXME
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
