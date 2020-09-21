module external.core.mutex;

import object;
import freertos;

@nogc:

class Mutex : Object.Monitor
{
    import core.sync.exception;
    import core.internal.abort;

    private SemaphoreHandle_t mtx = void;

    this() @nogc
    {
        mtx = _xSemaphoreCreateRecursiveMutex();

        if(mtx == null)
            abort("Error: memory required to hold mutex could not be allocated.");
    }

    ~this() @nogc
    {
        _vSemaphoreDelete(mtx);
    }

    final void lock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        // Infinity wait
        if(xSemaphoreTakeRecursive(mtx.unshare, portMAX_DELAY) != pdTRUE)
        {
            SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            syncErr.msg = "Unable to lock mutex.";
            throw syncErr;
        }
    }

    final void unlock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        if(xSemaphoreGiveRecursive(mtx.unshare) != pdTRUE)
        {
            SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            syncErr.msg = "Unable to unlock mutex.";
            throw syncErr;
        }
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

private QueueDefinition* unshare(T)(T mtx) pure nothrow
{
    return cast(QueueDefinition*) mtx;
}
