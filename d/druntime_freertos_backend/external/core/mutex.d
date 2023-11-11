module external.core.mutex;

import object;
import freertos;
import core.demangle: mangleFunc;

@nogc:

pragma(mangle, mangleFunc!(void* function() nothrow @nogc)("core.internal.mutex_freestanding.createRecursiveMutex"))
void* createRecursiveMutex() @nogc nothrow
{
    import core.internal.abort;

    void* mtx = _xSemaphoreCreateRecursiveMutex();

    if(mtx is null)
        abort("Error: memory required to hold mutex could not be allocated.");

    return mtx;
}

pragma(mangle, mangleFunc!(void function(void*) nothrow @nogc)("core.internal.mutex_freestanding.deleteRecursiveMutex"))
void deleteRecursiveMutex(void* mtx) @nogc nothrow
{
    _vSemaphoreDelete(cast(QueueDefinition*) mtx);
}

/+
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
+/
