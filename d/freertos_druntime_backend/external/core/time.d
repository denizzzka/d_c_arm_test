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
    //FIXME: implement it
    return TickDuration(789);
}

long currTicks = 789; //FIXME

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
