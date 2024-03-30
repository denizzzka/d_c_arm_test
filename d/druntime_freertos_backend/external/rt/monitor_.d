module external.rt.monitor_;

nothrow:
@nogc:

import freertos;
import external.core.mutex: _xSemaphoreCreateMutex, _xSemaphoreGive, _vSemaphoreDelete;
import core.exception;

private alias MonitorMutex = SemaphoreHandle_t;
alias Mutex = MonitorMutex;

void initMutex(MonitorMutex* mtx)
{
    *mtx = _xSemaphoreCreateMutex();

    if(*mtx is null)
        onOutOfMemoryError();
}

void destroyMutex(MonitorMutex* mtx)
{
    _vSemaphoreDelete(*mtx);
}

void lockMutex(MonitorMutex* mtx)
{
    if(xSemaphoreTake(*mtx, portMAX_DELAY) != pdTRUE)
        onInvalidMemoryOperationError();
}

void unlockMutex(MonitorMutex* mtx)
{
    if(_xSemaphoreGive(*mtx) != pdTRUE)
        onInvalidMemoryOperationError();
}
