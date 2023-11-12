module external.core.semaphore;

static import os = freertos;
import core.demangle: mangleFunc;
import core.exception: onOutOfMemoryError;
import core.time : Duration;

nothrow:
@nogc:

pragma(mangle, mangleFunc!(shared(void)* function(size_t))("core.internal.semaphore_freestanding.createCountingSemaphore"))
export os.SemaphoreHandle_t createCountingSemaphore(size_t initialCount) @trusted
{
    import core.stdc.config: c_long;

    auto m_hndl = os.xSemaphoreCreateCounting(c_long.max /* c_ulong */, initialCount);

    if(!m_hndl)
        onOutOfMemoryError();

    return m_hndl;
}

pragma(mangle, mangleFunc!(void function(shared(void)*))("core.internal.semaphore_freestanding.deleteCountingSemaphore"))
export void deleteCountingSemaphore(os.SemaphoreHandle_t m_hndl) @trusted
{
    os._vSemaphoreDelete(m_hndl);
}

pragma(mangle, mangleFunc!(bool function(shared(void)*))("core.internal.semaphore_freestanding.waitCountingSemaphore"))
export bool waitCountingSemaphore(os.SemaphoreHandle_t m_hndl) @trusted
{
    return os.xSemaphoreTake(m_hndl, os.portMAX_DELAY) == os.pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(shared(void)*, Duration))("core.internal.semaphore_freestanding.waitCountingSemaphoreWithTimeout"))
export bool waitCountingSemaphoreWithTimeout(os.SemaphoreHandle_t m_hndl, Duration period) @trusted
{
    import external.core.time: toTicks;

    return os.xSemaphoreTake(m_hndl, period.toTicks) == os.pdTRUE;
}

pragma(mangle, mangleFunc!(bool function(shared(void)*))("core.internal.semaphore_freestanding.giveCountingSemaphore"))
export bool giveCountingSemaphore(os.SemaphoreHandle_t m_hndl) @trusted
{
    return os._xSemaphoreGive(m_hndl) == os.pdTRUE;
}
