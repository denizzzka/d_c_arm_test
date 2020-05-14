add_languages('d', native:false)

dpp = subproject('dpp').get_variable('dpp_preprocessor')

root_dir = meson.source_root()
subprojects_dir = root_dir + '/subprojects/'

libopencm3_binding = dpp.process(
    files(
        'source/bindings/gpio.dpp',
    ),
    extra_args: [
        '--include-path=' + subprojects_dir + 'libopencm3/include/',
        '--define=STM32F1'
    ]
)

freertos_binding = dpp.process(
    files(
        'freertos_dpp_bindings/freertos.dpp',
    ),
    extra_args: [
        '--include-path=' + subprojects_dir + 'freertos/include/',
        '--include-path=' + subprojects_dir + 'freertos/portable/GCC/ARM_CM3/', #TODO: get this from freertos_dep?
        '--include-path=' + root_dir, #for FreeRTOSConfig.h
    ]
)

freertos_dep = declare_dependency(
    sources: [
        #freertos_binding,
        'freertos_dpp_bindings/freertos.d', #TODO: remove this file, https://github.com/mesonbuild/meson/issues/7140
    ],
    include_directories: include_directories(
        'freertos_dpp_bindings',
        'stm32_druntime_backend',
    )
)

stm32_druntime_backend = [
    'stm32_druntime_backend/external/core/abort.d',
    'stm32_druntime_backend/external/core/event.d',
    'stm32_druntime_backend/external/core/fiber.d',
    'stm32_druntime_backend/external/core/memory.d',
    'stm32_druntime_backend/external/core/thread.d',
    'stm32_druntime_backend/external/core/time.d',
    'stm32_druntime_backend/external/libc/errno.d',
    'stm32_druntime_backend/external/libc/stdio_.d',
    'stm32_druntime_backend/external/rt/config.d',
    'stm32_druntime_backend/external/rt/dmain.d',
    'stm32_druntime_backend/external/rt/monitor_.d',
    'stm32_druntime_backend/external/rt/sections.d',
]


druntime_dep = subproject('druntime').get_variable('druntime_dep')
druntime_lib = library(
    'druntime',
    sources: [
        stm32_druntime_backend,
    ],
    include_directories: include_directories(
        './stm32_druntime_backend/',
    ),
    dependencies: [
        druntime_dep,
        freertos_dep,
        picolibc_dep,
    ],
    d_module_versions: [
        'DruntimeAbstractRt',
        'CRuntime_Abstract',
        'ExternStackShell',
        'AsmExternal', #used by fiber module
    ],
)

d_dep = declare_dependency(
    sources: [
        'source/app.d',
        libopencm3_binding,
    ],
    include_directories: [
        'source',
        'source/bindings',
    ],
    dependencies: [
        freertos_dep,
    ],
    link_with: druntime_lib,
)
