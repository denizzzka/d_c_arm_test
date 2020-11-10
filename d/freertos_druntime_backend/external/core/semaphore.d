module external.core.semaphore;

static import os = freertos;
import core.stdc.errno;
import core.sync.exception: SyncError;
import external.core.time: toTicks;

class Semaphore
{
    private os.SemaphoreHandle_t m_hndl;

    this(size_t initialCount = 0) nothrow @nogc
    {
        import core.stdc.config: c_long;

        m_hndl = os.xSemaphoreCreateCounting(c_long.max /* c_ulong */, initialCount);

        assert(m_hndl);
    }

    ~this() nothrow @nogc
    {
        os._vSemaphoreDelete(m_hndl);

        debug m_hndl = null;
    }

    void wait()
    {
        if(!waitOrError())
            throw new SyncError("Unable to wait for semaphore");
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
        if(!notifyOrError())
            throw new SyncError("Unable to notify semaphore");
    }

    bool notifyOrError() nothrow @nogc
    {
        return os._xSemaphoreGive(m_hndl) == os.pdTRUE;
    }
}
