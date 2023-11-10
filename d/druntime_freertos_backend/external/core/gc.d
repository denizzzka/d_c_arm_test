module external.core.gc;

//TODO: need to fill core.gc.config.config __gshared struct before start

import core.internal.parseoptions;

struct Config
{
    bool disable;            // start disabled
    bool fork = false;       // optional concurrent behaviour
    ubyte profile;           // enable profiling with summary when terminating program
    string gc = "conservative"; // select gc implementation conservative|precise|manual

    size_t initReserve;      // initial reserve (bytes)
    size_t minPoolSize = 16 * 1024;  // initial and minimum pool size
    size_t maxPoolSize = 3 * 1024 * 1024;  // maximum pool size
    size_t incPoolSize = 4 * 1024;  // pool size increment

    uint parallel = 10;      // number of additional threads for marking (limited by cpuid.threadsPerCPU-1)
    float heapSizeFactor = 2.0; // heap size to used memory ratio
    string cleanup = "collect"; // select gc cleanup method none|collect|finalize

    bool initialize() @nogc nothrow
    {
        return true;
    }
}
