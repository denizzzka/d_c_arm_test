module external.core.semaphore;

static import os = freertos;
import core.stdc.errno;
import core.sync.exception: SyncError;
import external.core.time: toTicks;

enum SEM_VALUE_MAX = 0x7FFFU;

class Semaphore
{
    private os.SemaphoreHandle_t m_hndl;

    this(size_t initialCount = 0) nothrow @nogc
    {
        m_hndl = os.xSemaphoreCreateCounting(SEM_VALUE_MAX, initialCount);

        assert(m_hndl);
    }

    ~this() nothrow @nogc
    {
        os._vSemaphoreDelete(m_hndl);
    }

    private immutable unableToWait = "Unable to wait for semaphore";

    void wait()
    {
        if(waitOrError())
            throw new SyncError(unableToWait);
    }

    bool waitOrError() nothrow @nogc
    {
        return os.xSemaphoreTake(m_hndl, os.portMAX_DELAY) == os.pdTRUE;
    }

    import core.time;

    bool wait(Duration period)
    in(!period.isNegative)
    {
        return os.xSemaphoreTake(m_hndl, period.toTicks) == os.pdTRUE;
    }

    bool tryWait() nothrow @nogc
    {
        return os.xSemaphoreTake(m_hndl, 0) == os.pdTRUE;
    }

    void notify()
    {
        if(notifyOrError())
            throw new SyncError("Unable to notify semaphore");
    }

    bool notifyOrError() nothrow @nogc
    {
        return os._xSemaphoreGive(m_hndl) == os.pdTRUE;
    }
}
