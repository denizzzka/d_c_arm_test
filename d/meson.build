add_languages('d')

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

druntime_dep = subproject('druntime').get_variable('druntime_dep')

d_dep = library(
    'D code part',
    [
        'source/app.d',
        libopencm3_binding,
        freertos_binding,
    ],
    include_directories: ['source', 'source/bindings'],
    link_with: druntime_dep,
)
