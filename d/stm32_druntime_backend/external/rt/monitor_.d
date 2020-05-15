module external.rt.monitor_;

nothrow:
@nogc:

import freertos;

alias MonitorMutex = SemaphoreHandle_t;
alias Mutex = MonitorMutex;

void initMutex(MonitorMutex* mtx)
in(mtx is null)
out(;mtx !is null)
{
    *mtx = _xSemaphoreCreateMutex();
}

void destroyMutex(MonitorMutex* mtx)
{
    _vSemaphoreDelete(*mtx);
}

void lockMutex(MonitorMutex* mtx)
{
    if(xSemaphoreTake(*mtx, portMAX_DELAY) != pdTRUE)
        assert(false);
}

void unlockMutex(MonitorMutex* mtx)
{
    if(_xSemaphoreGive(*mtx) != pdTRUE)
        assert(false);
}
