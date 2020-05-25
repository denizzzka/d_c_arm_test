module external.core.semaphore;

import freertos;
import core.stdc.errno;
import core.sync.exception: SyncError;

enum SEM_VALUE_MAX = 0x7FFFU;

class Semaphore
{
    private SemaphoreHandle_t m_hndl;

    this(uint count = 0) nothrow @nogc
    {
        m_hndl = xSemaphoreCreateCounting(SEM_VALUE_MAX, count);

        assert(m_hndl);
    }

    ~this() nothrow @nogc
    {
        _vSemaphoreDelete(m_hndl);
    }

    private immutable unableToWait = "Unable to wait for semaphore";

    void wait()
    {
        if(xSemaphoreTakeRecursive(m_hndl, portMAX_DELAY) != pdTRUE)
            throw new SyncError(unableToWait);
    }

    import core.time;

    bool wait(Duration period)
    in(!period.isNegative)
    {
        MonoTime mt;
        mt += period;

        return xSemaphoreTakeRecursive(m_hndl, cast(uint) mt.ticks) != pdTRUE;
    }

    bool tryWait() nothrow @nogc
    {
        return xSemaphoreTakeRecursive(m_hndl, portMAX_DELAY) != pdTRUE;
    }

    void notify()
    {
        if(xSemaphoreGiveRecursive(m_hndl) != pdTRUE)
            throw new SyncError("Unable to notify semaphore");
    }
}
