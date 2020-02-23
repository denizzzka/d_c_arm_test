project(
    'C + D + FreeRTOS test project',
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)

picolibc_sub = subproject('picolibc', default_options: ['multilib=false'])
__picolibc_dep = picolibc_sub.get_variable('picolibc_dep')

picolibc_compile_args = [
    '-Wno-unknown-pragmas', #pragma diagnostic disabled
    '-Wno-empty-body', #warning: while loop has empty body
    '-Wno-unused-private-field', #private field '_lock' is not used
    '-D_WANT_IO_C99_FORMATS',
]

picolibc_dep = declare_dependency(
    dependencies: [__picolibc_dep],
    compile_args: picolibc_compile_args,
)

stm32f1_dep = subproject('libopencm3').get_variable('stm32f1_dep')
freertos_dep = subproject('freertos').get_variable('freertos_dep')
libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')
semihost_lib = picolibc_sub.get_variable('lib_semihost')

subdir('d')

executable(
    'firmware.elf',
    link_with: [d_dep, semihost_lib],
    dependencies: [
        stm32f1_dep,
        picolibc_dep,
        freertos_dep,
        libunwind_dep,
    ],
    link_language: 'c' # to avoid calling ldc2 as linker because it affected to "no source files" bug
)
