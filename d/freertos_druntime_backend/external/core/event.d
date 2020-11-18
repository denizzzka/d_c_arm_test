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
        uint r;

        // xEventGroupWaitBits can return immediately on some cases:
        // https://www.freertos.org/FreeRTOS_Support_Forum_Archive/February_2018/freertos_xEventGroupWaitBits_unexpected_behavior_cd13225cj.html
        do
        {
            r = os.xEventGroupWaitBits(
               group,
               BITS_MASK,
               clearOnExit,
               os.pdFALSE, // xWaitForAllBits
               os.portMAX_DELAY // xTicksToWait
            );
        }
        while(!r);

        assert(r & BITS_MASK);
    }

    bool wait(Duration tmout)
    in(!tmout.isNegative)
    in(group)
    {
        import external.core.time: currTicks;

        /*
        If the task that is waiting for event bits is also being suspended and 
        resumed then you could check the time before calling 
        xEventGroupWaitBits(), and then if the function returns without any bits 
        being set, check the time again to know if the function returned because 
        of a timeout.  If the requested block time has not expired, and no bits 
        are set, then you could assume the function returned because the task 
        got suspended and then resumed again.

        Posted by rtel on February 8, 2018
        */

        const timeoutTicks = tmout.toTicks();
        assert(timeoutTicks < uint.max);

        long startTime = currTicks();
        const endTime = startTime + timeoutTicks;

        do
        {
            long dt = endTime - startTime;

            assert(dt > 0);

            auto r = os.xEventGroupWaitBits(
               group,
               BITS_MASK,
               clearOnExit,
               os.pdFALSE, // xWaitForAllBits
               cast(uint) dt // xTicksToWait
            );

            if(r & BITS_MASK)
                return true;

            startTime = currTicks();
        }
        while(startTime < endTime);

        return false;
    }
}
