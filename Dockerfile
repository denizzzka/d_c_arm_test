FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y build-essential clang libclang-11-dev gcc-arm-none-eabi \
       dub ldc git lld llvm ninja-build python3 python3-pip python3-setuptools python3-wheel

# Install meson
ENV PATH=$PATH:/root/.local/bin
RUN pip3 install --user meson

# Patch phobos for FreeRTOS
RUN sed -i 's/else static assert(0, "Unknown OS.");/else OS os = OS.otherNonPosix;/g' /usr/lib/ldc/x86_64-linux-gnu/include/d/std/system.d \
	&& sed -i 's/otherPosix /otherPosix, otherNonPosix /g' /usr/lib/ldc/x86_64-linux-gnu/include/d/std/system.d

# Patch ldc druntime
RUN cd /tmp && git clone https://github.com/denizzzka/druntime \
    && cd /usr/lib/ldc/x86_64-linux-gnu/include/d/ && rm -r core \
	&& ln -s /tmp/druntime/src/core/ core
	
# Compile
ENV DFLAGS="-L=-L/usr/lib/llvm-11/lib/"
COPY . /tmp/project
RUN cd /tmp/project \
    && meson setup --cross-file arm_cortex_m4_cross.ini -Doptimization=s -Ddebug=true /tmp/project/build

# Run ninja 3 times - workaround for https://github.com/denizzzka/d_c_arm_test/issues/2
#                                and https://github.com/mesonbuild/meson/issues/6677
RUN cd /tmp/project/build && (ninja >/dev/null || true)
RUN cd /tmp/project/build && (ninja >/dev/null || true)
RUN sleep 1
RUN cd /tmp/project/build && ninja
