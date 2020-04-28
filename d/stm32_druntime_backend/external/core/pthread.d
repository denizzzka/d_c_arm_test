//TODO: rename to external.core.thread
module external.core.pthread;

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

void thread_intermediateShutdown() nothrow @nogc
{
    assert(false, "Not implemented");
}

extern(D) public void callWithStackShell(scope void delegate(void* sp) nothrow fn) nothrow
{
    assert(false, "Not implemented");
}

class Thread
{
    /// Main process thread
    private __gshared Thread    sm_main;

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
    //
    // Remove a thread from the global thread list.
    //
    static void remove(Thread t) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    static struct Context
    {
    }
}
