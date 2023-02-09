module external.rt.sections_riscv32;

version(RISCV32):

extern(C) extern void syscalls_init() nothrow @nogc
{
}

static import freertos;
import external.rt.sections: read_tp_secondary;
import external.libc.stdlib: aligned_alloc;
import core.memory: GC;

private enum TCB_size = 8; // ARM EABI specific

/***
 * Called once per thread; returns array of thread local storage ranges
 */
void[] initTLSRanges() nothrow @nogc
{
    debug(PRINTF) printf("external initTLSRanges called\n");

    debug
    {
        assert(read_tp_secondary() is null, "TLS already initialized?");
    }

    import external.rt.sections: getTLSParams;

    auto p = getTLSParams();

    // TLS
    import core.stdc.string: memcpy, memset;

    void* tls = aligned_alloc(8, p.full_tls_size);
    assert(tls, "cannot allocate TLS block");

    // Copying TLS data
    memcpy(tls, p.tdata_start, p.tdata_size);

    // Init local bss by zeroes
    memset(tls + p.tdata_size, 0x00, p.tbss_size);

    assert(false, "TODO: TCB-related stuff is from ARM, need to change");
    freertos.vTaskSetThreadLocalStoragePointer(null, 0, tls - TCB_size /* ARM EABI specific offset */);

    debug
    {
        void* tls_arm = read_tp_secondary();
        assert(tls - tls_arm == TCB_size);
    }

    // Register in GC
    //TODO: move this info into our own SectionGroup implementation?
    GC.addRange(tls, p.full_tls_size);

    return tls[0 .. p.full_tls_size];
}
