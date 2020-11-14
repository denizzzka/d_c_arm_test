module external.core.types;

import freertos: TaskHandle_t;
import external.core.mutex: Mutex;

alias ThreadID = TaskHandle_t;

struct ll_ThreadData
{
    import external.core.event: Event;
    import core.atomic;

    ThreadID tid;
    Event joinEvent;
    private shared size_t joinEventSubscribersNum;

    void initialize() nothrow @nogc
    {
        joinEvent.initialize(true, false);
    }

    auto getSubscribersNum()
    {
        return atomicLoad(joinEventSubscribersNum);
    }

    void deletionLock() @nogc nothrow
    {
        joinEventSubscribersNum.atomicOp!"+="(1);
    }

    void deletionUnlock() @nogc nothrow
    {
        joinEventSubscribersNum.atomicOp!"-="(1);
    }
}

unittest
{
    ll_ThreadData td;
    td.initialize();

    assert(td.getSubscribersNum() == 0);
    td.deletionLock();
    assert(td.getSubscribersNum() == 1);
    td.deletionLock();
    assert(td.getSubscribersNum() == 2);
    td.deletionUnlock();
    assert(td.getSubscribersNum() == 1);
    td.deletionUnlock();
    assert(td.getSubscribersNum() == 0);
}
