module external.core.event;

static import os = freertos;
import core.time;
import external.core.time: toTicks;

struct Event
{
    private os.EventGroupHandle_t group;
    private os.BaseType_t clearOnExit;

    nothrow @nogc:

    this(bool manualReset, bool initialState) @safe
    {
        initialize(manualReset, initialState);
    }

    void initialize(bool manualReset, bool initialState) @trusted
    in(group is null)
    {
        import core.internal.abort: abort;

        group = os.xEventGroupCreate();

        if(group is null)
            abort("xEventGroupCreate failed");

        clearOnExit = manualReset ? os.pdFALSE : os.pdTRUE;

        if(initialState)
            set();
    }

    // copying not allowed, can produce resource leaks
    @disable this(this);
    @disable void opAssign(Event);

    ~this() @safe
    {
        terminate();
    }

    void terminate() @trusted
    in(group)
    {
        os.vEventGroupDelete(group);
        group = null;
    }

    bool setIfInitialized()
    {
        if(group is null)
            return false;
        else
        {
            set();

            return true;
        }
    }

    private enum uint BITS_MASK = 0x01; // using one first bit

    void set()
    in(group)
    {
        os.xEventGroupSetBits(group, BITS_MASK);
    }

    void reset()
    in(group)
    {
        os.xEventGroupClearBits(group, BITS_MASK);
    }

    void wait()
    in(group)
    {
        auto r = os.xEventGroupWaitBits(
           group,
           BITS_MASK,
           clearOnExit,
           os.pdFALSE, // xWaitForAllBits
           os.portMAX_DELAY // xTicksToWait
        );

        assert(r & BITS_MASK, "Timeout can't expire in this function");
    }

    bool wait(Duration tmout)
    in(!tmout.isNegative)
    in(group)
    {
        auto r = os.xEventGroupWaitBits(
           group,
           BITS_MASK,
           clearOnExit,
           os.pdFALSE, // xWaitForAllBits
           tmout.toTicks // xTicksToWait
        );

        return r & BITS_MASK;
    }
}
