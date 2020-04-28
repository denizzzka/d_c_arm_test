module external.core.mutex;

import object;

class Mutex : Object.Monitor
{
    final void lock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        assert(false, "Not implemented");
    }

    final void unlock_nothrow(this Q)() nothrow @trusted @nogc
    if (is(Q == Mutex) || is(Q == shared Mutex))
    {
        assert(false, "Not implemented");
    }
}
