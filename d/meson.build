add_languages('d', native:false)

dpp = subproject('dpp').get_variable('dpp_preprocessor')

root_dir = meson.source_root()
subprojects_dir = root_dir + '/subprojects/'

libopencm3_binding = dpp.process(
    meson.current_source_dir() + '/source/bindings/gpio.dpp',
    extra_args: ['--include-path=' + subprojects_dir + 'libopencm3/include/', '--define=STM32F1']
)

#freertos_dep = subproject('freertos').get_variable('freertos_dep')

freertos_binding = dpp.process(
    meson.current_source_dir() + '/source/bindings/freertos.dpp',
    extra_args: [
        '--include-path=' + subprojects_dir + 'freertos/include/',
        '--include-path=' + subprojects_dir + 'freertos/portable/GCC/ARM_CM3/', #TODO: get this from freertos_dep?
        '--include-path=' + root_dir, #for FreeRTOSConfig.h
        #'--no-sys-headers',
    ]
)


stm32_druntime_backend = [
    'stm32_druntime_backend/external/core/abort.d',
    'stm32_druntime_backend/external/core/fiber.d',
    'stm32_druntime_backend/external/core/memory.d',
    'stm32_druntime_backend/external/core/pthread.d',
    'stm32_druntime_backend/external/core/time.d',
    'stm32_druntime_backend/external/rt/config.d',
    'stm32_druntime_backend/external/rt/monitor_.d',
    'stm32_druntime_backend/external/rt/sections.d',
    'stm32_druntime_backend/libc/stdio_.d',
]

druntime_dep = subproject('druntime').get_variable('druntime_dep')
druntime_lib = library(
    'druntime',
    stm32_druntime_backend,
    include_directories: include_directories('stm32_druntime_backend'),
    dependencies: druntime_dep,
    d_module_versions: [
        'DruntimeAbstractRt',
        'CRuntime_Abstract',
        'ExternStackShell',
        'AsmExternal', #used by fiber module
    ],
    d_args: ['-defaultlib='],
)

d_dep = library(
    'D code part',
    [
        'source/app.d',
        libopencm3_binding,
        freertos_binding,
    ],
    include_directories: ['source', 'source/bindings'],
    link_with: druntime_lib,
)
