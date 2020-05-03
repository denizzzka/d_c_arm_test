project(
    'C + D + FreeRTOS test project',
    ['d'],
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)

picolibc_sub = subproject(
    'picolibc',
    default_options: [
        'multilib=false',
    ]
)
picolibc_dep = picolibc_sub.get_variable('picolibc_dep')
semihost_lib = picolibc_sub.get_variable('lib_semihost')

libopencm3_sub = subproject('libopencm3')
libopencm3_dep = libopencm3_sub.get_variable('libopencm3_dep')
ld_script_gen = libopencm3_sub.get_variable('ld_script_gen')

freertos_dep = subproject('freertos').get_variable('freertos_dep')
libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

subdir('d')

executable(
    'firmware.elf',
    link_with: [d_dep, semihost_lib],
    dependencies: [
        libopencm3_dep,
        picolibc_dep,
        freertos_dep,
        libunwind_dep,
    ],
    link_language: 'd',
    link_args: [
#        '-L=--script=' + ld_script,
    ],
)
