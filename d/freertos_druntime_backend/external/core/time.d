module external.core.time;

enum ClockType
{
    normal = 0,
    //~ coarse = 2,
    //~ precise = 3,
    second = 6, //TODO: used only for druntime core unittest, do something with this
}

import core.time;

//FIXME: TickDuration is deprecated!
static @property TickDuration currSystemTick() @trusted nothrow @nogc
{
    return TickDuration(currTicks);
}

//FIXME: dirty implementation, only for unittests
long currTicks() @trusted nothrow @nogc
{
    __gshared static long curr;

    curr++;

    return curr;
}

uint toTicks(Duration d) @safe nothrow @nogc pure
{
    long r = d.total!"usecs" * (tickDuration_ticksPerSec / 1_000_000);

    assert(r <= uint.max);

    return cast(uint) r;
}

enum tickDuration_ticksPerSec = 1_000_000;

void initTicksPerSecond(ref long[] tps)
{
    tps[0] = tickDuration_ticksPerSec; // ClockType.normal
}

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
