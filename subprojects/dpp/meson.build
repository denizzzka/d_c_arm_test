project('d++ preprocessor')

dub = find_program('dub', native: true)

dpp_preprocessor = generator(
    dub,
    arguments : [
        'run', 'dpp', '--',
        '--preprocess-only',
        '--source-output-path=@BUILD_DIR@',
        '@EXTRA_ARGS@',
        '@INPUT@',
    ],
    output: '@BASENAME@.d',
)
