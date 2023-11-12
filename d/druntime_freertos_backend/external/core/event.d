module external.core.event;

static import os = freertos;
import core.demangle: mangleFunc;
import core.time : Duration;

nothrow:
@nogc:
@safe:

pragma(mangle, mangleFunc!(void* function())("core.internal.event_freestanding.createEvent"))
export os.EventGroupHandle_t createEvent() @trusted
{
    import core.internal.abort: abort;

    os.EventGroupHandle_t group = os.xEventGroupCreate();

    if(group is null)
        abort("xEventGroupCreate failed");

    return group;
}

pragma(mangle, mangleFunc!(void function(void*))("core.internal.event_freestanding.terminateEvent"))
export void terminateEvent(os.EventGroupHandle_t group) @trusted
{
    os.vEventGroupDelete(group);
    group = null;
}

private enum uint BITS_MASK = 0x01; // using one first bit

pragma(mangle, mangleFunc!(void function(void*))("core.internal.event_freestanding.setEvent"))
export void setEvent(os.EventGroupHandle_t group) @trusted
{
    os.xEventGroupSetBits(group, BITS_MASK);
}

pragma(mangle, mangleFunc!(void function(void*))("core.internal.event_freestanding.clearEvent"))
export void clearEvent(os.EventGroupHandle_t group) @trusted
{
    os.xEventGroupClearBits(group, BITS_MASK);
}

pragma(mangle, mangleFunc!(void function(void*, bool))("core.internal.event_freestanding.waitEvent"))
export void waitEvent(os.EventGroupHandle_t group, bool clearOnExit) @trusted
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

pragma(mangle, mangleFunc!(bool function(void*, bool, Duration))("core.internal.event_freestanding.waitEventWithTimeout"))
export bool waitEventWithTimeout(os.EventGroupHandle_t group, bool clearOnExit, Duration tmout) @trusted
{
    import external.core.time: currTicks, toTicks;

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
