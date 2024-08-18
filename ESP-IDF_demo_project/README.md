Run D code on ESP32-c3
===============================

# Build runtime and Phobos

Build runtime and Phobos as described at https://github.com/denizzzka/dfruntime

# Activate ESP IDF environment

Install [ESP IDF](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/index.html).
Then install ESP clang environment:
```
> idf_tools.py install esp-clang
```

Inside of each terminal session which will be used for compilation of ESP IDF code
activate ESP IDE by command:

```
> source path/to/Espressif_IDE/esp-idf-v5.2.1/export.fish
```

This is the usual way of working with ESP IDE

# Create ESP-IDF binding if needed

When a new version of ESP IDF comes out, it would be nice to update D binding.
There are different ways, I suggest using [mc2d](https://code.dlang.org/packages/mc2d) tool.
In my opinion, it gives the best and fastest results.

```
> ./d_binding_creation/create_d_binding.sh
```

Now `./preprocessed/esp_idf.d` contains just created binding.

Since creating a binding is a complex process with many involved tools, I put binding
for the current ESP IDF release into the file `main/esp_idf_binding.d`.
Bump me when a new version comes out and I'll update it.

# Compiling "Hello, world!" project

Finally, everything is ready to build and flash our first D project for ESP-IDF platform.

```
> DFLAGS="--conf=/path/to/dfruntime/install_freertos_riscv32/etc/ldc2_tagged.conf" \
    idf.py \
    --build-dir=builddir \
    -D CMAKE_BUILD_TYPE=Debug \
    set-target esp32c3 build

> idf.py --build-dir=builddir flash
```
