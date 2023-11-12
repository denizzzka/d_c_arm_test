module external.core.thread;

import core.demangle: mangleFunc;
import core.internal.spinlock;
import core.sync.event: Event;
import core.stdc.stdlib: aligned_alloc, realloc, free;
import core.time;
import core.thread.osthread;
import core.thread.threadbase;
import core.thread.types: ThreadID, ll_ThreadData;
import core.thread.context: StackContext;
static import os = freertos;
import freertos: TaskHandle_t;

enum DefaultTaskPriority = 3;
enum DefaultStackSize = 2048 * os.StackType_t.sizeof;

extern(C) void thread_entryPoint(void* arg) nothrow
in(arg)
{
    auto obj = cast(Thread) arg;

    scope(exit)
    {
        obj.isRunning = false;
        obj.taskProperties.joinEvent.setIfInitialized();
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

import core.demangle : mangleFunc;

alias LLThreadDg = void delegate() nothrow;

private struct LLTaskProperties
{
    LLThreadDg dg;
}

/**
 * Create a thread not under control of the runtime, i.e. TLS module constructors are
 * not run and the GC does not suspend it during a collection.
 *
 * Params:
 *  dg        = delegate to execute in the created thread.
 *  stacksize = size of the stack of the created thread. The default of 0 will select the
 *              platform-specific default size.
 *  cbDllUnload = Windows only: if running in a dynamically loaded DLL, this delegate will be called
 *              if the DLL is supposed to be unloaded, but the thread is still running.
 *              The thread must be terminated via `joinLowLevelThread` by the callback.
 *
 * Returns: the platform specific thread ID of the new thread. If an error occurs, `ThreadID.init`
 *  is returned.
 */
pragma(mangle, mangleFunc!(ThreadID function(LLThreadDg dg, uint stacksize, LLThreadDg cbDllUnload) nothrow @nogc)("core.thread.osthread.createLowLevelThread"))
extern(D) export ThreadID createLowLevelThread(
    LLThreadDg dg,
    uint stacksize = 0,
    LLThreadDg cbDllUnload = null
) nothrow @nogc
in(stacksize % os.StackType_t.sizeof == 0)
{
    import core.stdc.stdlib: malloc;
    import core.stdc.string: memset;

    auto context = cast(LLTaskProperties*) malloc(LLTaskProperties.sizeof);
    if(!context) return ThreadID.init;

    *context = LLTaskProperties(dg);

    lowlevelLock.lock_nothrow();
    scope(exit) lowlevelLock.unlock_nothrow();

    ll_nThreads++;
    auto new_ll_pThreads = cast(ll_ThreadData*) realloc(ll_pThreads, ll_ThreadData.sizeof * ll_nThreads);
    if(!new_ll_pThreads) return ThreadID.init;
    ll_pThreads = new_ll_pThreads;

    if(stacksize == 0)
        stacksize = DefaultStackSize;

    auto wordsStackSize = stacksize / os.StackType_t.sizeof;
    if(wordsStackSize < os.configMINIMAL_STACK_SIZE)
        return ThreadID.init;

    auto stackBuff = cast(os.StackType_t*) aligned_alloc(os.StackType_t.sizeof, stacksize);
    auto tcb = cast(os.StaticTask_t*) malloc(os.StaticTask_t.sizeof);

    auto currThread = &ll_pThreads[ll_nThreads - 1];
    memset(currThread, 0x00, ll_ThreadData.sizeof);
    currThread.initialize();

    immutable (char*) name = "D low-level";

    currThread.tid = os.xTaskCreateStatic(
        &lowlevelThread_entryPoint,
        name,
        wordsStackSize,
        cast(void*) context, // pvParameters*
        DefaultTaskPriority,
        stackBuff,
        tcb
    );

    // xTaskCreateStatic returns 0 if some error occured, ensure what this is ThreadID.init
    static assert(ThreadID.init is null);

    return currThread.tid;
}

private extern(C) void lowlevelThread_entryPoint(void* ctx) nothrow
{
    LLTaskProperties lltp = *cast(LLTaskProperties*) ctx; 
    free(ctx);

    lltp.dg();

    ThreadID tid = os.xTaskGetCurrentTaskHandle();

    lowlevelLock.lock_nothrow();

    ll_ThreadData* td = getLLThreadNotThreadSafe(tid);
    assert(td);

    td.joinEvent.setIfInitialized();

    lowlevelLock.unlock_nothrow();

    //FIXME: replace this dumb condvar implementation
    while(td.getSubscribersNum() != 0)
    {
        os.vTaskDelay(100); // ticks, 0.1 second
    }

    ll_removeThread(tid);

    os.vTaskDelete(null);
}

extern(C) export void joinLowLevelThread(ThreadID tid) nothrow @nogc
{
    ll_ThreadData* t = lockAndGetLowLevelThread(tid);

    if(t is null) // thread already exited
        return;

    t.joinEvent.wait();

    t.deletionUnlock(); // then thread can be safely deleted
}

private ll_ThreadData* lockAndGetLowLevelThread(in ThreadID tid) nothrow @nogc
{
    lowlevelLock.lock_nothrow();

    auto t = getLLThreadNotThreadSafe(tid);

    // thread still not deleted? lock its deletion
    if(t !is null)
        t.deletionLock();

    lowlevelLock.unlock_nothrow();

    return t;
}

private ll_ThreadData* getLLThreadNotThreadSafe(in ThreadID tid) nothrow @nogc
{
    foreach (i; 0 .. ll_nThreads)
    {
        auto curr = &ll_pThreads[i];

        if (tid is curr.tid)
            return curr;
    }

    return null;
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

extern (C) static Thread thread_findByAddr(ThreadID addr) nothrow
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

private TaskHandle_t mAddr(Thread t) nothrow
{
    return cast(TaskHandle_t) t.m_addr;
}

private void mAddr(Thread t, TaskHandle_t val) nothrow
{
    t.m_addr = cast(void*) val;
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
        os.vTaskSuspend(t.mAddr);
    }
    else if (!t.m_lock)
    {
        t.m_curr.tstack = getStackTop();
    }

    return true;
}

pragma(mangle, mangleFunc!(void function(ThreadBase) nothrow @nogc)("core.thread.osthread.resume"))
extern(D) export void resume(ThreadBase _t) nothrow @nogc
{
    Thread t = _t.toThread;

    if(t.m_addr != os.xTaskGetCurrentTaskHandle())
    {
        os.vTaskResume(t.mAddr);
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

pragma(mangle, mangleFunc!(void* function() nothrow @nogc)("core.thread.osthread.getStackBottom"))
export void* getStackBottom() nothrow @nogc
{
    assert(Thread.getThis().m_main.bstack !is null);

    return Thread.getThis().m_main.bstack;
}

bool findLowLevelThread(ThreadID tid) nothrow @nogc
{
    assert(false, "Not implemented");
}

pragma(mangle, mangleFunc!(ThreadBase function(ThreadBase) nothrow @nogc)("core.thread.osthread.attachThread"))
export ThreadBase external_attachThread(ThreadBase thisThread) nothrow @nogc
{
    Thread t = thisThread.toThread;

    StackContext* thisContext = &thisThread.m_main;
    assert(thisContext);
    assert(thisContext == t.m_curr);

    t.m_addr = os.xTaskGetCurrentTaskHandle();
    assert(thisContext.bstack);
    thisContext.tstack = thisContext.bstack;

    t.isRunning = true;
    t.m_isDaemon = true;
    t.tlsGCdataInit();
    Thread.setThis(t);

    ThreadBase.add( t, false );
    ThreadBase.add( thisContext );
    if ( Thread.sm_main !is null )
        multiThreadedFlag = true;

    return t;
}

pragma(mangle, mangleFunc!(void function(Thread) nothrow @nogc @safe)("core.internal.thread_freestanding.initTaskProperties"))
private void initTaskProperties(Thread t) @safe @nogc nothrow
{
    import core.exception: onOutOfMemoryError;

    if(t._m_sz == 0)
        t._m_sz = DefaultStackSize;

    assert(t._m_sz <= ushort.max * size_t.sizeof, "FreeRTOS stack size limit");
    assert(t._m_sz % os.StackType_t.sizeof == 0, "Stack size must be multiple of word");

    t.taskProperties.stackBuff = (() @trusted => aligned_alloc(os.StackType_t.sizeof, t._m_sz))();
    if(!t.taskProperties.stackBuff)
        onOutOfMemoryError();

    t.m_main.bstack = (() @trusted => t.taskProperties.stackBuff + t._m_sz - 1)();
}

pragma(mangle, mangleFunc!(Thread function(Thread) nothrow @nogc)("core.internal.thread_freestanding.thread_start"))
Thread thread_start(Thread t) nothrow @nogc
{
    auto wasThreaded  = multiThreadedFlag;
    multiThreadedFlag = true;
    scope( failure )
    {
        if ( !wasThreaded )
            multiThreadedFlag = false;
    }

    t.slock.lock_nothrow();
    scope(exit) t.slock.unlock_nothrow();

    {
        ++t._nAboutToStart;
        t._pAboutToStart = cast(ThreadBase*) realloc(t._pAboutToStart, Thread.sizeof * t._nAboutToStart);
        t._pAboutToStart[t._nAboutToStart - 1] = t;

        auto wordsStackSize = t._m_sz / os.StackType_t.sizeof;
        assert(wordsStackSize >= os.configMINIMAL_STACK_SIZE);

        t.isRunning = true;
        scope(failure) t.isRunning = false;

        t.mAddr = os.xTaskCreateStatic(
            &thread_entryPoint,
            cast(const(char*)) "D thread", //FIXME: fill name from m_name
            wordsStackSize,
            cast(void*) t, // pvParameters*
            DefaultTaskPriority,
            cast(os.StackType_t*) t.taskProperties.stackBuff,
            cast(os.StaticTask_t*) &t.taskProperties.task_control_block
        );

        return t;
    }
}

pragma(mangle, mangleFunc!(Throwable function(Thread, bool) @nogc)("core.internal.thread_freestanding.thread_join"))
Throwable thread_join(Thread t, bool rethrow) @nogc
{
    assert(t.taskProperties.stackBuff !is null, "Can't join main thread");

    t.taskProperties.joinEvent.wait();

    t.mAddr = t.mAddr.init;

    if (t.m_unhandled)
    {
        if (rethrow)
            throw t.m_unhandled;
        return t.m_unhandled;
    }

    return null;
}

pragma(mangle, mangleFunc!(void function(Duration) @nogc nothrow)("core.internal.thread_freestanding.Thread.sleep"))
void sleep(Duration val) @nogc nothrow
{
    import external.core.time;

    os.vTaskDelay(val.toTicks);
}

pragma(mangle, mangleFunc!(void function() @nogc nothrow)("core.internal.thread_freestanding.Thread.yield"))
static void yield() @nogc nothrow
{
    _taskYield();
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

shared SpinLock memLock = SpinLock(SpinLock.Contention.lengthy);

extern(C) void __malloc_lock()
{
    memLock.lock();
}

extern(C) void __malloc_unlock()
{
    memLock.unlock();
}
