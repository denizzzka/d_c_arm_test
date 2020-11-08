module external.core.event;

static import os = freertos;
import core.time;

struct Event
{
    private os.EventGroupHandle_t group;
    private os.BaseType_t clearOnExit;

    nothrow @nogc:

    this(bool manualReset, bool initialState)
    {
        initialize(manualReset, initialState);
    }

    void initialize(bool manualReset, bool initialState)
    {
        import core.exception: onOutOfMemoryError;

        group = os.xEventGroupCreate();

        if(group is null)
            onOutOfMemoryError();

        clearOnExit = manualReset ? os.pdFALSE : os.pdTRUE;

        if(initialState)
            set();
    }

    // copying not allowed, can produce resource leaks
    @disable this(this);
    @disable void opAssign(Event);

    ~this()
    {
        terminate();
    }

    void terminate()
    {
        os.vEventGroupDelete(group);
        group = null;
    }

    private enum BITS_MASK = 0x01; // using one first bit

    void set()
    {
        os.xEventGroupSetBits(group, BITS_MASK);
    }

    void reset()
    {
        os.xEventGroupClearBits(group, BITS_MASK);
    }

    bool wait()
    {
        auto r = os.xEventGroupWaitBits(
           group,
           BITS_MASK,
           clearOnExit,
           false, // xWaitForAllBits
           os.portMAX_DELAY // xTicksToWait
        );

        return r & BITS_MASK;
    }

    bool wait(Duration tmout)
    in(!tmout.isNegative)
    {
        auto mt = MonoTime.currTime;
        mt += tmout;

        auto r = os.xEventGroupWaitBits(
           group,
           BITS_MASK,
           clearOnExit,
           false, // xWaitForAllBits
           cast(uint) mt.ticks // xTicksToWait
        );

        return r & BITS_MASK;
    }
}
