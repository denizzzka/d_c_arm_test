FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y build-essential clang libclang-11-dev gcc-arm-none-eabi \
       dub ldc git lld llvm ninja-build python3 python3-pip python3-setuptools python3-wheel

# Install meson
ENV PATH=$PATH:/root/.local/bin
RUN pip3 install --user meson

# Compile
ENV DFLAGS="-L=-L/usr/lib/llvm-11/lib/"
COPY . /tmp/project
RUN cd /tmp/project \
    && meson setup --cross-file arm_cortex_m4_cross.ini -Doptimization=s -Ddebug=true /tmp/project/build

# One threaded build - workaround for https://github.com/denizzzka/d_c_arm_test/issues/2
RUN cd /tmp/project/build && ninja -j1
