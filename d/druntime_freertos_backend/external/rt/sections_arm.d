module external.rt.sections_arm;

version(ARM):

/+
static import freertos;
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
        assert(__aeabi_read_tp() is null, "TLS already initialized?");
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

    freertos.vTaskSetThreadLocalStoragePointer(null, 0, tls - TCB_size /* ARM EABI specific offset */);

    debug
    {
        void* tls_arm = __aeabi_read_tp();
        assert(tls - tls_arm == TCB_size);
    }

    // Register in GC
    //TODO: move this info into our own SectionGroup implementation?
    GC.addRange(tls, p.full_tls_size);

    return tls[0 .. p.full_tls_size];
}
+/

extern(C) extern void* __aeabi_read_tp() nothrow @nogc
{
    import ldc.llvmasm;
    import external.rt.sections: read_tp_secondary;

    // TODO: For unknown reason __aeabi_read_tp() is not preserves registers by itself. Why?
    //
    // Preserve registers due to
    // Thread-local storage (new in v2.01)
    // https://developer.arm.com/documentation/ihi0043/latest/
    __asm(`push {r1, r2, r3}`, ``);

    auto ret = read_tp_secondary();

    __asm(`pop {r1, r2, r3}`, ``);

    return ret;
}
