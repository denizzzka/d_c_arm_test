BUILD STEPS:

cd into this git repository and:

$ meson setup --cross-file arm_cortex_m3_cross.ini builddir

TODO:

- Cover libopencm3 by Meson (only dirty workaround is implemented)
- Cover FreeRTOS by Meson (ditto)
