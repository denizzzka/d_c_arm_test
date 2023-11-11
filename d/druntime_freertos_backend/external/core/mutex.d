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
    _vSemaphoreDelete(mtx.unshare);
}

pragma(mangle, mangleFunc!(bool function(void*) nothrow @nogc)("core.internal.mutex_freestanding.takeMutexRecursive"))
bool takeMutexRecursive(void* mtx) @nogc nothrow
{
    return xSemaphoreTakeMutexRecursive(mtx.unshare, portMAX_DELAY) != pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(void*) nothrow @nogc)("core.internal.mutex_freestanding.giveMutexRecursive"))
bool giveMutexRecursive(void* mtx) @nogc nothrow
{
    return xSemaphoreGiveMutexRecursive(mtx.unshare) != pdTRUE;
}

private QueueDefinition* unshare(T)(T mtx) pure nothrow
{
    return cast(QueueDefinition*) mtx;
}
