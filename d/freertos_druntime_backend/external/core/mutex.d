module external.core.mutex;

import object;

@nogc:

class Mutex : Object.Monitor
{
    import freertos;
    import core.sync.exception;
    import core.internal.abort;

    private SemaphoreHandle_t mtx = void;

    this() @nogc
    {
        //~ mtx = xSemaphoreCreateRecursiveMutex();

        if(mtx == null)
            abort("Error: memory required to hold mutex could not be allocated.");

        assert(false, "FIXME: not implemented");
    }

    ~this() @nogc
    {
        _vSemaphoreDelete(mtx);
    }

    final void lock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        //~ // Infinity wait
        //~ if(xSemaphoreTakeRecursive(mtx, portMAX_DELAY) != pdTRUE)
        //~ {
            //~ SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            //~ syncErr.msg = "Unable to lock mutex.";
            //~ throw syncErr;
        //~ }

        assert(false, "Unimplemented");
    }

    final void unlock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        //~ if(xSemaphoreGiveRecursive(mtx) != pdTRUE)
        //~ {
            //~ SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            //~ syncErr.msg = "Unable to unlock mutex.";
            //~ throw syncErr;
        //~ }

        assert(false, "Unimplemented");
    }

    @trusted void lock()
    {
        lock_nothrow();
    }

    /// ditto
    @trusted void lock() shared
    {
        lock_nothrow();
    }

    @trusted void unlock()
    {
        unlock_nothrow();
    }

    /// ditto
    @trusted void unlock() shared
    {
        unlock_nothrow();
    }
}
