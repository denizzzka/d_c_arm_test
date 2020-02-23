project('libunwind',['c', 'cpp'])

includes = include_directories(
    'include',
    'include/mach-o',
    'src',
)

c_src = files(
    'src/UnwindLevel1.c',
    #'src/UnwindLevel1-gcc-ext.c', #for GCC only
    'src/Unwind-sjlj.c',
)

asm_src = files(
    'src/UnwindRegistersRestore.S',
    'src/UnwindRegistersSave.S',
)

cxx_src = files(
    'src/libunwind.cpp',
    'src/Unwind-EHABI.cpp',
    'src/Unwind-seh.cpp',
)

headers = files(
    'src/AddressSpace.hpp',
    'src/assembly.h',
    'src/CompactUnwinder.hpp',
    'src/config.h',
    'src/dwarf2.h',
    'src/DwarfInstructions.hpp',
    'src/DwarfParser.hpp',
    'src/EHHeaderParser.hpp',
    'src/libunwind_ext.h',
    'src/Registers.hpp',
    'src/RWMutex.hpp',
    'src/Unwind_AppleExtras.cpp',
    'src/UnwindCursor.hpp',
    'src/Unwind-EHABI.h',
)

libunwind_dep = declare_dependency(
    sources:[c_src, cxx_src, asm_src],
    include_directories: [
        includes,
    ],
    compile_args: [
        '-D_LIBUNWIND_IS_BAREMETAL',
        '-D_LIBUNWIND_HAS_NO_THREADS',
        '-DNDEBUG',
    ],
)
