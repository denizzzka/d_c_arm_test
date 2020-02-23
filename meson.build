project(
    'C + D + FreeRTOS test project',
    version: 'v0.0.1',
    default_options: [
        'default_library=static' #move out it
    ]
)

stm32f1_dep = subproject('libopencm3').get_variable('stm32f1_dep')
freertos_dep = subproject('freertos').get_variable('freertos_dep')
libunwind_dep = subproject('libunwind').get_variable('libunwind_dep')

subdir('d')

executable(
    'firmware.elf',
    #link_with: [d_dep, libunwind_dep],
    dependencies: [stm32f1_dep, freertos_dep, libunwind_dep],
    link_language: 'c' # to avoid calling ldc2 as linker because it affected to "no source files" bug
)
