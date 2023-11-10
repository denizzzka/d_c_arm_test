module external.core.time;

/+
enum ClockType
{
    normal = 0,
    //~ coarse = 2,
    //~ precise = 3,
    second = 6, //TODO: used only for druntime core unittest, do something with this
}
+/

import core.demangle : mangleFunc;
import core.time;

//FIXME: remove, TickDuration is deprecated!
pragma(mangle, mangleFunc!(TickDuration function() @trusted @property nothrow @nogc)("core.time.TickDuration.currSystemTick"))
export static @property TickDuration currSystemTick() @trusted nothrow @nogc
{
    return TickDuration(currTicks);
}

static import os = freertos;

extern(C) export long currTicks() @trusted nothrow @nogc
{
    return os.xTaskGetTickCount();
}

//TODO: templatize this calculations to avoid wasting CPU time
uint toTicks(Duration d) @safe nothrow @nogc pure
in(_ticksPerSec >= 1000)
{
    long r = _ticksPerSec / 1000 * d.total!"msecs";

    assert(r <= uint.max);

    return cast(uint) r;
}

unittest
{
    assert(1.seconds.toTicks == _ticksPerSec);
}

enum _ticksPerSec = os.configTICK_RATE_HZ;

extern(C) export void initTicksPerSecond(ref long[] tps) @nogc nothrow
{
    tps[0] = _ticksPerSec; // ClockType.normal
}

/+
// Linked by picolibc
struct timeval {
    long    tv_sec;     /* seconds */
    long    tv_usec;    /* and microseconds */
}

extern(C) int gettimeofday(timeval* tv, void*) // timezone_t* is normally void*
{
    //FIXME
    tv.tv_sec = 123;
    tv.tv_usec = 456;

    return 0;
}
+/
