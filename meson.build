project(
    'C + D + FreeRTOS test project',
    ['d'],
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)


flto_type = 'thin'

add_global_arguments('-flto=' + flto_type, language: 'c')
add_global_arguments('--flto=' + flto_type, language: 'd')
add_global_link_arguments(
    '-Xlinker', '--fatal-warnings',
    '-flto=' + flto_type,
    language: 'c'
)
add_global_link_arguments(
    '-Xlinker', '--fatal-warnings',
    '--flto=' + flto_type,
    language: 'd'
)

picolibc_sub = subproject(
    'picolibc',
    default_options: [
        'multilib=false',
        'newlib-io-c99-formats=true',
    ]
)
picolibc_dep = picolibc_sub.get_variable('picolibc_dep')
semihost_lib = picolibc_sub.get_variable('lib_semihost')

libopencm3_sub = subproject('libopencm3')
libopencm3_dep = libopencm3_sub.get_variable('libopencm3_dep')
ld_script_gen = libopencm3_sub.get_variable('ld_script_gen')

freertos_dep = subproject('freertos').get_variable('freertos_dep')
libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

ld_aliases_for_picolibc = files('aliases_for_picolibc.ld')

ld_script = ld_script_gen.process(
    ld_aliases_for_picolibc, #unused, just to satisfy generator
    extra_args: [
        'DEVICE=stm32f103x8',
        'ARCH_FLAGS=-D_EH_FRAME',
    ]
)

ld_script_path = 'linker_script.ld'

# Copies generated file to make it acessible for .ini file
ld_script_with_known_name = custom_target(
    'concat .ld files and copy it to known place',
    command : [ 'cat', '@INPUT@' ],
    capture: true,
    input: [ld_script, ld_aliases_for_picolibc],
    output: ld_script_path,
)

run_target(
    'ld_script_gen',
    command: ['echo', 'generate ld script'],
    depends: ld_script_with_known_name,
)

subdir('d')

executable(
    'firmware.elf',
    dependencies: [
        d_dep,
        libopencm3_dep,
        picolibc_dep,
        freertos_dep,
        libunwind_dep,
    ],
    link_with: [
        semihost_lib,
    ],
    link_language: 'c',
    link_depends: ld_script_with_known_name,
    link_args: [
        '-Xlinker', '--script=' + ld_script_path,
        '-L/usr/lib/gcc/arm-none-eabi/8.3.1/thumb/v7-m/nofp/', '-lgcc',
    ]
)
