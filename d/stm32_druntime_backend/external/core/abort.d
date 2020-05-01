module external.core.abort;

void abort(scope string msg, scope string filename = __FILE__, size_t line = __LINE__) @nogc nothrow @safe
{
    assert(false, "Not implemented");
}
