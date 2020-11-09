module external.core.event;

static import os = freertos;
import core.time;
import external.core.time: toTicks;

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
        if(group !is null)
            os.xEventGroupSetBits(group, BITS_MASK);
    }

    void reset()
    {
        if(group !is null)
            os.xEventGroupClearBits(group, BITS_MASK);
    }

    bool wait()
    {
        if(group is null)
            return false;

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
        if(group is null)
            return false;

        auto r = os.xEventGroupWaitBits(
           group,
           BITS_MASK,
           clearOnExit,
           false, // xWaitForAllBits
           tmout.toTicks // xTicksToWait
        );

        return r & BITS_MASK;
    }
}
