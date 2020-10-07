project(
    'C + D + FreeRTOS test project',
    ['d'],
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)

#TODO: keep until will not be fixed https://github.com/mesonbuild/meson/issues/7154
if get_option('dlang_lto')
    lto_type = 'full'
    lto_d = '--flto=' + lto_type #saves ~100KB
else
    lto_d = ''
endif

add_global_arguments(
    language: 'c'
)
add_global_arguments(
    lto_d,
    '--boundscheck=off', #saves 1.4KB
    '--d-version=DruntimeAbstractRt', #TODO: https://github.com/mesonbuild/meson/issues/7168
    '--d-version=CRuntime_Abstract', #TODO: https://github.com/mesonbuild/meson/issues/7168
    '--d-version=AsmExternal', #TODO: ditto
    '--d-version=GENERIC_IO', #TODO: ditto, used by Phobos
    language: 'd'
)
add_global_link_arguments(
    '-Xlinker', '--fatal-warnings',
    language: 'c'
)
add_global_link_arguments(
    lto_d,
    '-L=--fatal-warnings',
    language: 'd'
)

picolibc_sub = subproject(
    'picolibc',
    default_options: [
        'multilib=false',
        'newlib-io-c99-formats=true',
        'newlib-long-time_t=true',
        'newlib-multithread=true',
    ]
)
picolibc_dep = picolibc_sub.get_variable('picolibc_dep')
semihost_lib = picolibc_sub.get_variable('lib_semihost')

libopencm3_sub = subproject('libopencm3')
libopencm3_dep = libopencm3_sub.get_variable('libopencm3_dep')

libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

freertos_lib = library(
    'freertos',
    dependencies: [
      subproject('freertos').get_variable('freertos_dep'),
      picolibc_dep,
    ],
)

subdir('d')

executable(
    'firmware.elf',
    dependencies: [
        d_dep,
        libopencm3_dep,
        picolibc_dep,
        #libunwind_dep,
    ],
    link_with: [
        semihost_lib,
    ],
    link_language: 'c',
    link_args: [
        '-Xlinker', '--script=../linker_script.ld', #FIXME: hardcoded path
        '-L/usr/lib/gcc/arm-none-eabi/8.3.1/thumb/v7-m/nofp/', '-lgcc',
    ]
)
