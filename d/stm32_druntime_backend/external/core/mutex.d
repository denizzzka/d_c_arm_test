module external.core.mutex;

import object;

class Mutex : Object.Monitor
{
    import freertos;
    import core.sync.exception;

    private SemaphoreHandle_t mtx = void;

    this()
    {
        mtx = xSemaphoreCreateMutex();

        if(mtx == null)
            abort("Error: memory required to hold mutex could not be allocated.");
    }

    ~this()
    {
        vSemaphoreDelete(mtx);
    }

    final void lock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        // Infinity wait, requires INCLUDE_vTaskSuspend = 1
        // TODO: compile-time check INCLUDE_vTaskSuspend == 1
        if(xSemaphoreTake(mtx, portMAX_DELAY) != pdTRUE)
        {
            SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            syncErr.msg = "Unable to lock mutex.";
            throw syncErr;
        }
    }

    final void unlock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        if(_xSemaphoreGive(mtx) != pdTRUE)
        {
            SyncError syncErr = cast(SyncError) cast(void*) typeid(SyncError).initializer;
            syncErr.msg = "Unable to unlock mutex.";
            throw syncErr;
        }
    }
}
