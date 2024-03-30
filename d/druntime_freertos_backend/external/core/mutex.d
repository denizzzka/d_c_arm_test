module external.core.mutex;

import object;
import freertos;

@nogc:

auto _xSemaphoreCreateMutex()
{
    return xQueueCreateMutex(queueQUEUE_TYPE_MUTEX);
}

auto _xSemaphoreCreateRecursiveMutex()
{
    return xQueueCreateMutex(queueQUEUE_TYPE_RECURSIVE_MUTEX);
}

auto _vSemaphoreDelete(SemaphoreHandle_t xSemaphore)
{
    return vQueueDelete(xSemaphore);
}

auto _xSemaphoreGive(SemaphoreHandle_t xSemaphore)
{
    return xQueueGenericSend(xSemaphore, null, semGIVE_BLOCK_TIME, queueSEND_TO_BACK);
}

class Mutex : Object.Monitor
{
    import core.sync.exception;
    import core.internal.abort;

    private SemaphoreHandle_t mtx = void;

    this() @nogc nothrow
    {
        mtx = _xSemaphoreCreateRecursiveMutex();

        if(mtx is null)
            abort("Error: memory required to hold mutex could not be allocated.");
    }

    this() @nogc shared
    {
        assert(false);
    }

    ~this() @nogc nothrow
    {
        _vSemaphoreDelete(mtx);
    }

    final void lock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        // Infinity wait
        if(xSemaphoreTakeMutexRecursive(mtx.unshare, portMAX_DELAY) != pdTRUE)
        {
            SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            syncErr.msg = "Unable to lock mutex.";
            throw syncErr;
        }
    }

    final void unlock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        if(xSemaphoreGiveMutexRecursive(mtx.unshare) != pdTRUE)
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
