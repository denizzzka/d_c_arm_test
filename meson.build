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

ld_script = ld_script_gen.process(
    files('unused.ld'), #to satisfy generator
    extra_args: [
        'DEVICE=stm32f103x8',
        'ARCH_FLAGS=-D_EH_FRAME',
    ]
)

ld_script_generated = custom_target(
    'linker script install',
    input: ld_script,
    output: 'linker_script.ld',
    command: ['cp', '@INPUT@', '@OUTPUT@'],
)

run_target(
    'ld_script_gen',
    command: ['echo', 'Linker script generated'],
    depends: ld_script_generated,
)

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
    link_depends: ld_script_generated,
)
