module external.rt.dmain;

void createCLIargs(int argc, char** argv, out char[][] args, out size_t totalArgsLength)
{
}

//~ import ldc.attributes;

// Graceful exit from Qemu or semihosting if program is tested or call hardware fault in other case
//~ @section(".fini_array")
//~ immutable exitFromUnittests_ptr = &exitFromUnittests;

//~ extern(C) void exitFromUnittests()
//~ {
    //~ _exit(0);
//~ }

//~ extern(C) void _exit(int) nothrow @nogc;
