project('d++ parser')

dub_ensure_available = find_program('dub', native: true)
helper = find_program('dpp_helper.sh', native: true)

dpp_parser = generator(
    helper,
    arguments : [
        '@INPUT@',
        '@BUILD_DIR@/@BASENAME@.dpp',
        '--preprocess-only',
        '@EXTRA_ARGS@',
    ],
    output: '@BASENAME@.d',
    preserve_path_from: meson.current_source_dir(),
)
