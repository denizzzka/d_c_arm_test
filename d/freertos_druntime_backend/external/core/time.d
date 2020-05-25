module external.core.time;

enum ClockType
{
    normal = 0,
    //~ coarse = 2,
    //~ precise = 3,
    second = 6, //TODO: used only for druntime core unittest, do something with this
}

import core.time : TickDuration; //FIXME: deprecated!

static @property TickDuration currSystemTick() @trusted nothrow @nogc
{
    assert(false, "Not implemented");
}

long currTicks; //FIXME

void initTicksPerSecond(ref long[] tps)
{
    //FIXME
    enum ticksPerSecond = 1_000_000;

    tps[0] = ticksPerSecond; // ClockType.normal
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
