project('d++ preprocessor')

dub = find_program('dub', native: true)

dpp_preprocessor = generator(
    dub,
    arguments : [
        #FIXME: remove ~master when dpp version greater than v0.4.13 will be available
        'run', 'dpp@~master', '--',
        '--preprocess-only',
        '--source-output-path=@BUILD_DIR@',
        '@EXTRA_ARGS@',
        '@INPUT@',
    ],
    output: '@BASENAME@.d',
)
