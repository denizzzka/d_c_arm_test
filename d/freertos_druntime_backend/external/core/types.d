module external.core.types;

import freertos: TaskHandle_t;

alias ThreadID = TaskHandle_t;

struct ll_ThreadData
{
    import external.core.mutex: Mutex;
    import external.core.event: Event;

    ThreadID tid;
    Event joinEvent;
    private void[__traits(classInstanceSize, Mutex)] lockDeletionObject;

    void initialize() nothrow @nogc
    {
        joinEvent.initialize(true, false);

        lockDeletionObject = typeid(Mutex).initializer[];
        (cast(Mutex) lockDeletionObject.ptr).__ctor();
    }

    Mutex lockDeletion() @nogc nothrow
    {
        return *cast(Mutex*) lockDeletionObject.ptr;
    }
}

unittest
{
    ll_ThreadData td;
    td.initialize();

    td.lockDeletion.lock();
    td.lockDeletion.unlock();
}
