module external.core.abort;

export void abort(scope string msg, scope string filename = __FILE__, size_t line = __LINE__) @nogc nothrow @safe
{
    import ldc.intrinsics;

    // Replaces unimplemented ldc2 --checkaction=halt_debug option
    // https://github.com/ldc-developers/ldc/issues/3454

    while(true)
        llvm_debugtrap();
}
