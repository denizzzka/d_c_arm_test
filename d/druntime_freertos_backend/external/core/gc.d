module external.core.gc;

import core.gc.config : Config;

extern(C) export bool initConfigOptions(ref Config cfg, string cfgname)
{
    Config c = {
        fork: false,        // optional concurrent behaviour
        gc: "conservative", // select gc implementation conservative|precise|manual
        minPoolSize: 16 * 1024,       // initial and minimum pool size
        maxPoolSize: 3 * 1024 * 1024, // maximum pool size
        incPoolSize: 4 * 1024,        // pool size increment
        parallel: 10,        // number of additional threads for marking (limited by cpuid.threadsPerCPU-1)
        heapSizeFactor: 2.0, // heap size to used memory ratio
        cleanup: "collect",  // select gc cleanup method none|collect|finalize
    };

    cfg = c;

    return false;
}
