project(
    'C + D + FreeRTOS test project',
    ['d'],
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)

picolibc_sub = subproject('picolibc', default_options: ['multilib=false'])
picolibc_dep = picolibc_sub.get_variable('picolibc_dep')

semihost_lib = picolibc_sub.get_variable('lib_semihost')
stm32f1_dep = subproject('libopencm3').get_variable('stm32f1_dep')
freertos_dep = subproject('freertos').get_variable('freertos_dep')
libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

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
