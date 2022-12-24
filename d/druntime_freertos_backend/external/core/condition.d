module external.core.condition;

import core.sync.mutex;
import core.time;

class Condition
{
    this(Mutex m, size_t capacity = 0) nothrow
    {
        assert(false, "Not implemented");
    }

    this(shared Mutex m, size_t capacity = 0) shared nothrow
    {
        assert(false, "Not implemented");
    }

    void wait() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    bool wait(Duration dur) nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    bool wait(Duration dur) shared nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    void wait() shared nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    bool tryNotify()
    {
        assert(false, "Not implemented");
    }

    void notify() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    void notify() shared nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    void notifyAll() nothrow @nogc
    {
        assert(false, "Not implemented");
    }

    void notifyAll() shared nothrow @nogc
    {
        assert(false, "Not implemented");
    }
}
