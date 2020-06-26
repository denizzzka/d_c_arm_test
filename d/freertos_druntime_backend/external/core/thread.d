module external.core.thread;

import core.thread.osthread;
import core.thread.threadbase;
import core.thread.context: StackContext;
import external.libc.config: c_ulong;

alias ThreadID = c_ulong;

@nogc:
nothrow:

/// Init threads module
extern (C) void thread_init() @nogc
{
    // Threads storage
    assert(typeid(Thread).initializer.ptr);
    _mainThreadStore[] = typeid(Thread).initializer[];

    // Creating main thread
    Thread.sm_main = external_attachThread((cast(Thread)_mainThreadStore.ptr).__ctor());
}

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
    assert(false, "Not implemented");
}

void thread_intermediateShutdown() nothrow @nogc
{
    assert(false, "Not implemented");
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
    Thread t = cast(Thread) thisThread; //FIXME: remove cast

    Thread.setThis(t); //FIXME: remove cast

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

    static void initLocks() @nogc
    {
        //~ assert(false, "Not implemented");
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

    import external.core.mutex: Mutex;

    @property static Mutex criticalRegionLock() nothrow @nogc
    {
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

    @property static Mutex slock() nothrow @nogc
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
