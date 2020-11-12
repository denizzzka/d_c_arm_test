module external.core.thread;

import core.sync.event: Event;
import core.stdc.stdlib: realloc, free;
import core.time;
import core.thread.osthread;
import core.thread.threadbase;
import core.thread.types: ThreadID;
import core.thread.context: StackContext;
static import os = freertos;

struct TaskProperties
{
    os.StaticTask_t tcb;
    Event joinEvent;
    void* stackBuff;
}

extern(C) void thread_entryPoint(void* arg) nothrow
in(arg)
{
    auto obj = cast(Thread) arg;

    scope(exit)
    {
        obj.taskProperties.joinEvent.set();
        os.vTaskDelete(null);
    }

    obj.initDataStorage();

    Thread.setThis(obj);

    ThreadBase.add(obj);
    scope(exit) ThreadBase.remove(obj);

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

struct LowLevelThreadSystemParams
{
    const(char*) name = "D low-level";
}

alias LLThreadDg = void delegate() nothrow;

/**
 * Create a thread not under control of the runtime, i.e. TLS module constructors are
 * not run and the GC does not suspend it during a collection.
 *
 *  cbDllUnload = Windows only: if running in a dynamically loaded DLL, this delegate will be called
 *              if the DLL is supposed to be unloaded, but the thread is still running.
 *              The thread must be terminated via `joinLowLevelThread` by the callback.
 */
ThreadID createLowLevelThread(
    LLThreadDg dg, uint stacksize = 0,
    LLThreadDg cbDllUnload = null, //TODO: remove this arg in upstream
    LowLevelThreadSystemParams params = LowLevelThreadSystemParams.init
) nothrow @nogc
in(stacksize % os.StackType_t.sizeof == 0)
{
    import core.sys.posix.stdlib: malloc;

    auto context = cast(LLThreadDg*) malloc(dg.sizeof);
    if(!context) return ThreadID.init;

    *context = dg;

    import core.thread.types: ll_ThreadData;

    lowlevelLock.lock_nothrow();
    scope(exit) lowlevelLock.unlock_nothrow();

    ll_nThreads++;
    auto new_ll_pThreads = cast(ll_ThreadData*) realloc(ll_pThreads, ll_ThreadData.sizeof * ll_nThreads);
    if(!new_ll_pThreads) return ThreadID.init;
    ll_pThreads = new_ll_pThreads;

    static extern(C) void thread_lowlevelEntry(void* ctx) nothrow
    {
        auto dg = *cast(void delegate() nothrow*) ctx;
        free(ctx);

        dg();

        os.vTaskDelete(null);
    }

    auto wordsStackSize = stacksize / os.StackType_t.sizeof; // add stack size checker

    import external.rt.sections: aligned_alloc;

    auto stackBuff = cast(os.StackType_t*) aligned_alloc(os.StackType_t.sizeof, stacksize);
    auto tcb = cast(os.StaticTask_t*) malloc(os.StaticTask_t.sizeof);

    ThreadID tid = os.xTaskCreateStatic(
        &thread_lowlevelEntry,
        params.name,
        wordsStackSize,
        cast(void*) context, // pvParameters*
        5, // uxPriority
        stackBuff,
        tcb
    );

    ll_pThreads[ll_nThreads - 1].tid = tid;

    return tid;
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

    // Creating main thread
    Thread mainThread = (cast(Thread) _mainThreadStore.ptr).__ctor();

    import external.rt.dmain: mainTaskProperties;
    mainThread.m_main.bstack = mainTaskProperties.stackBottom;

    ThreadBase.sm_main = external_attachThread(mainThread);
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

//FIXME: name must be "resume", extern(D)
private extern(C) void _D8external4core6thread6resumeFNbCQxQu10threadbase10ThreadBaseZv(ThreadBase _t) nothrow
{
    Thread t = _t.toThread;

    if(t.m_addr != os.xTaskGetCurrentTaskHandle())
    {
        os.vTaskResume(t.m_addr);
    }
    else if ( !t.m_lock )
    {
        t.m_curr.tstack = t.m_curr.bstack;
    }
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
    assert(Thread.getThis().m_main.bstack !is null);

    return Thread.getThis().m_main.bstack;
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
    assert(thisContext.bstack);
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
    private TaskProperties taskProperties;

    /// Initializes a thread object which has no associated executable function.
    /// This is used for the main thread initialized in thread_init().
    private this(size_t sz = 0) @safe pure nothrow @nogc
    {
    }

    this(void function() fn, size_t sz = 0, /* string file = __FILE__, size_t line = __LINE__ */) @safe nothrow
    in(fn !is null)
    {
        super(fn, sz);
        initTaskProperties();
        taskProperties.joinEvent = Event(true, false);
        //printTcbCreated(file, line);
    }

    this(void delegate() dg, size_t sz = 0, /* string file = __FILE__, size_t line = __LINE__ */) @safe nothrow
    in(dg !is null)
    {
        super(dg, sz);
        initTaskProperties();
        taskProperties.joinEvent = Event(true, false);
        //printTcbCreated(file, line);
    }

    ~this() nothrow @nogc
    {
        if(taskProperties.stackBuff) // not main thread
            free(taskProperties.stackBuff);

        destructBeforeDtor();
    }

    private void initTaskProperties() @safe nothrow
    {
        import external.rt.sections: aligned_alloc;
        import core.exception: onOutOfMemoryError;

        if(m_sz == 0)
            m_sz = 2048 * size_t.sizeof; // default stack size

        assert(m_sz <= ushort.max * size_t.sizeof, "FreeRTOS stack size limit");
        assert(m_sz % os.StackType_t.sizeof == 0, "Stack size must be multiple of word");

        taskProperties.stackBuff = (() @trusted => aligned_alloc(os.StackType_t.sizeof, m_sz))();
        if(!taskProperties.stackBuff)
            onOutOfMemoryError();

        m_main.bstack = (() @trusted => taskProperties.stackBuff + m_sz - 1)();
    }

    private void printTcbCreated(string file, size_t line) @trusted nothrow
    {
        debug(PRINTF)
        {
            import core.stdc.stdio: printf;

            printf("TCB %p created from file %s line %d\n", &taskProperties.tcb, cast(char*) file, line);
        }
    }

    private void initDataStorage() nothrow
    {
        assert(m_curr is &m_main);

        assert(m_main.bstack);
        m_main.tstack = m_main.bstack;

        tlsGCdataInit();
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
            ++nAboutToStart;
            pAboutToStart = cast(ThreadBase*)realloc(pAboutToStart, Thread.sizeof * nAboutToStart);
            pAboutToStart[nAboutToStart - 1] = this;

            auto wordsStackSize = m_sz / os.StackType_t.sizeof;

            m_addr = os.xTaskCreateStatic(
                &thread_entryPoint,
                cast(const(char*)) "D thread", //FIXME: fill name from m_name
                wordsStackSize,
                cast(void*) this, // pvParameters*
                5, // uxPriority
                cast(os.StackType_t*) taskProperties.stackBuff,
                &taskProperties.tcb
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
        assert(taskProperties.stackBuff !is null, "Can't join main thread");

        //FIXME: remove loop. Currently wait() call isn't works (FreeRTOS-related problem?)
        while(!taskProperties.joinEvent.wait(1.seconds)){}

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

    static void sleep(Duration val) @nogc nothrow
    {
        import external.core.time;

        os.vTaskDelay(val.toTicks);
    }

    static void yield() @nogc nothrow
    {
        _taskYield();
    }
}

private void _taskYield() @nogc nothrow
{
    version(__ARM_ARCH_ISA_ARM)
    {
        // taskYield() code what dpp can't convert from FreeRTOS headers

        /* Set a PendSV to request a context switch. */
        //os.portNVIC_INT_CTRL_REG = os.portNVIC_PENDSVSET_BIT;
        __gshared portNVIC_INT_CTRL_REG = cast(uint*) 0xe000ed04;
        portNVIC_INT_CTRL_REG = os.portNVIC_PENDSVSET_BIT;

        /* Barriers are normally not required but do ensure the code is completely
         * within the specified behaviour for the architecture. */
        // __asm volatile ( "dsb" ::: "memory" );
        // __asm volatile ( "isb" );

        __asm!()(`
            dsb memory
            isb
        `);
    }
    else
        static assert("Not implemented");
}

private Thread toThread(ThreadBase t) @trusted nothrow @nogc pure
{
    return cast(Thread) cast(void*) t;
}

// Picolibc malloc threads support:
private:

import core.internal.spinlock;

shared SpinLock memLock = SpinLock(SpinLock.Contention.medium);

extern(C) void __malloc_lock()
{
    memLock.lock();
}

extern(C) void __malloc_unlock()
{
    memLock.unlock();
}
