module external.core.time;

enum ClockType
{
    normal = 0,
    //~ coarse = 2,
    //~ precise = 3,
    //~ second = 6,
}

import core.time : TickDuration; //FIXME: deprecated!

static @property TickDuration currSystemTick() @trusted nothrow @nogc
{
    assert(false, "Not implemented");
}

static @property auto /*MonoTimeImpl*/ currTime() @trusted nothrow @nogc
{
    assert(false, "Not implemented");
}
