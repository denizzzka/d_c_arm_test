module external.core.mutex;

import object;
import freertos;
import core.demangle: mangleFunc;
import core.internal.monitor_freestanding: MonitorMutex;

@nogc:

pragma(mangle, mangleFunc!(MonitorMutex function() nothrow @nogc)("core.internal.mutex_freestanding.createMutex"))
MonitorMutex createMutex() @nogc nothrow
{
    import core.exception : onOutOfMemoryError;

    void* mtx = _xSemaphoreCreateMutex();

    if(mtx is null)
        onOutOfMemoryError();

    return cast(shared) mtx;
}

pragma(mangle, mangleFunc!(shared(void)* function() nothrow @nogc)("core.internal.mutex_freestanding.createRecursiveMutex"))
shared(void)* createRecursiveMutex() @nogc nothrow
{
    import core.internal.abort;

    void* mtx = _xSemaphoreCreateRecursiveMutex();

    if(mtx is null)
        abort("Error: memory required to hold mutex could not be allocated.");

    return cast(shared) mtx;
}

pragma(mangle, mangleFunc!(void function(MonitorMutex) nothrow @nogc)("core.internal.mutex_freestanding.deleteMutex"))
void deleteMutex(MonitorMutex mtx) @nogc nothrow
{
    _vSemaphoreDelete(mtx.unshare);
}

pragma(mangle, mangleFunc!(void function(shared void*) nothrow @nogc)("core.internal.mutex_freestanding.deleteRecursiveMutex"))
void deleteRecursiveMutex(shared void* mtx) @nogc nothrow
{
    _vSemaphoreDelete(mtx.unshare);
}

pragma(mangle, mangleFunc!(bool function(MonitorMutex) nothrow @nogc)("core.internal.mutex_freestanding.takeMutex"))
bool takeMutex(MonitorMutex mtx) @nogc nothrow
{
    return xSemaphoreTake(mtx.unshare, portMAX_DELAY) == pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(shared void*) nothrow @nogc)("core.internal.mutex_freestanding.takeMutexRecursive"))
bool takeMutexRecursive(shared void* mtx) @nogc nothrow
{
    return xSemaphoreTakeMutexRecursive(mtx.unshare, portMAX_DELAY) == pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(MonitorMutex) nothrow @nogc)("core.internal.mutex_freestanding.giveMutex"))
bool giveMutex(MonitorMutex mtx) @nogc nothrow
{
    return _xSemaphoreGive(mtx.unshare) == pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(shared void*) nothrow @nogc)("core.internal.mutex_freestanding.giveMutexRecursive"))
bool giveMutexRecursive(shared void* mtx) @nogc nothrow
{
    return xSemaphoreGiveMutexRecursive(mtx.unshare) == pdTRUE;
}

private QueueDefinition* unshare(T)(T mtx) pure nothrow
{
    return cast(QueueDefinition*) mtx;
}
