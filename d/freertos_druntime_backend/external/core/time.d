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
    foreach (i, typeStr; __traits(allMembers, ClockType))
    {
        static if (typeStr != "second")
        {
            tps[i] = 1_000_000; //FIXME
        }
    }
}
