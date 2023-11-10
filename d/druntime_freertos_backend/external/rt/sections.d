module external.rt.sections;

static import freertos;
import core.demangle: mangleFunc;

/+
import rt.sections_ldc : SectionGroup;
debug(PRINTF) import core.stdc.stdio : printf;

// These values described in linker script
extern(C) extern __gshared void* _data;
extern(C) extern __gshared void* _ebss;

extern(C) extern __gshared void* _tdata;
extern(C) extern __gshared void* _tdata_size;
extern(C) extern __gshared void* _tbss;
extern(C) extern __gshared void* _tbss_size;

struct TLSParams
{
    void* tdata_start;
    size_t tdata_size;
    void* tbss_start;
    size_t tbss_size;
    size_t full_tls_size;
}

TLSParams getTLSParams() nothrow @nogc
{
    auto tdata_start = cast(void*)&_tdata;
    auto tbss_start = cast(void*)&_tbss;
    size_t tdata_size = cast(size_t)&_tdata_size;
    size_t tbss_size = cast(size_t)&_tbss_size;
    size_t full_tls_size = tdata_size + tbss_size;

    assert(tbss_size > 1);

    return TLSParams(
        tdata_start,
        tdata_size,
        tbss_start,
        tbss_size,
        full_tls_size
    );
}

void fillGlobalSectionGroup(ref SectionGroup gsg) nothrow @nogc
{
    debug(PRINTF) printf(__FUNCTION__~" called\n");

    // Writeable (non-TLS) data sections covered by GC
    auto data_start = cast(void*)&_data;
    ptrdiff_t size = cast(void*)&_ebss - data_start;

    gsg._gcRanges.insertBack(data_start[0 .. size]);

    debug(PRINTF) printf(__FUNCTION__~" done\n");
}
+/

pragma(mangle, mangleFunc!(void function(void[]) nothrow @nogc)("rt.sections_ldc.finiTLSRanges"))
export void finiTLSRanges(void[] rng) nothrow @nogc
{
    import core.stdc.stdlib: free;

    debug(PRINTF) printf("finiTLSRanges called\n");

    assert(read_tp_secondary() !is null);

    free(rng.ptr);
}

package void* read_tp_secondary() nothrow @nogc
{
    return freertos.pvTaskGetThreadLocalStoragePointer(null, 0);
}

/+
void ctorsDtorsWarning() nothrow
{
    static assert("Deprecation 16211");
/*
    fprintf(stderr, "Deprecation 16211 warning:\n"
        ~ "A cycle has been detected in your program that was undetected prior to DMD\n"
        ~ "2.072. This program will continue, but will not operate when using DMD 2.074\n"
        ~ "to compile. Use runtime option --DRT-oncycle=print to see the cycle details.\n");
 */
}
+/
