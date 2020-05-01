//TODO: rename to external.core.thread
module external.core.pthread;

import core.thread.osthread: ScanAllThreadsTypeFn, IsMarkedDg;
import libc.config: c_ulong;

alias ThreadID = c_ulong;

extern (C) void thread_init() @nogc
{
    assert(false, "Not implemented");
}

extern (C) void thread_term() @nogc
{
    assert(false, "Not implemented");
}

extern (C) bool thread_isMainThread() nothrow @nogc
{
    //~ return Thread.getThis() is Thread.sm_main;
    assert(false, "Not implemented");
}

extern (C) Thread thread_attachThis()
{
    assert(false, "Not implemented");
}

static Thread thread_findByAddr(ThreadID addr)
{
    assert(false, "Not implemented");
}

extern (C) void thread_joinAll()
{
    assert(false, "Not implemented");
}

extern (C) void thread_suspendAll() nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_resumeAll() nothrow
{
    assert(false, "Not implemented");
}

extern (C) void thread_scanAllType( scope ScanAllThreadsTypeFn scan ) nothrow
{
    assert(false, "Not implemented");
}

void thread_intermediateShutdown() nothrow @nogc
{
    assert(false, "Not implemented");
}

extern(C) void thread_processGCMarks( scope IsMarkedDg isMarked ) nothrow
{
    assert(false, "Not implemented");
}

extern(D) public void callWithStackShell(scope void delegate(void* sp) nothrow fn) nothrow
{
    assert(false, "Not implemented");
}

version (LDC_Windows)
{
    import ldc.attributes;

    void* getStackBottom() nothrow @nogc @naked
    {
        assert(false, "Not implemented");
    }
} else {
    void* getStackBottom() nothrow @nogc
    {
        assert(false, "Not implemented");
    }
}

extern (C) void* thread_stackBottom() nothrow @nogc
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

class Thread
{
    /// Main process thread
    private __gshared Thread    sm_main;

    bool m_isInCriticalRegion;

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
        assert(false, "Not implemented");
    }

    /// Sets a thread-local reference to the current thread object.
    static void setThis(Thread t) nothrow @nogc
    {
        //~ sm_this = t;
        assert(false, "Not implemented");
    }

    static Thread getThis() @safe nothrow @nogc
    {
        // NOTE: This function may not be called until thread_init has
        //       completed.  See thread_suspendAll for more information
        //       on why this might occur.
        //~ return sm_this;
        assert(false, "Not implemented");
    }

    final @property bool isRunning() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    import external.core.mutex: Mutex;

    @property static Mutex criticalRegionLock() nothrow @nogc
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

    final Throwable join( bool rethrow = true )
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

    static struct Context
    {
    }
}
