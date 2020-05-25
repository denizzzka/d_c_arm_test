module external.core.semaphore;

import freertos;
import core.stdc.errno;
import core.sync.exception: SyncError;

enum SEM_VALUE_MAX = 0x7FFFU;

class Semaphore
{
    private SemaphoreHandle_t m_hndl;

    this(uint count = 0)
    {
        m_hndl = xSemaphoreCreateCounting(SEM_VALUE_MAX, count);

        assert(m_hndl);
    }

    ~this()
    {
        _vSemaphoreDelete(m_hndl);
    }

    void wait()
    {
        if(xSemaphoreTakeRecursive(m_hndl, portMAX_DELAY) != pdTRUE)
            throw new SyncError("Unable to wait for semaphore");
    }

    void notify()
    {
        if(xSemaphoreGiveRecursive(m_hndl) != pdTRUE)
            throw new SyncError("Unable to notify semaphore");
    }
}
