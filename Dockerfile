FROM debian:unstable-20240311-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

ARG INST="apt-get install --no-install-recommends -y"

RUN $INST build-essential clang libclang-dev
RUN $INST python3 python3-setuptools python3-wheel
RUN $INST pipx
RUN $INST git ninja-build
RUN $INST wget ca-certificates
RUN $INST lld llvm

# Install meson
ENV PATH=$PATH:/root/.local/bin
RUN pipx install meson

# Install ldc2
ARG ldc2_ver=v1.40.0
RUN wget -qO ldc2.tar.xz https://github.com/ldc-developers/ldc/releases/download/$LDC2_VER/ldc2-$LDC2_VER-linux-x86_64.tar.xz
RUN mkdir /ldc_standalone
RUN tar xf ldc2.tar.xz -C /ldc_standalone
ENV PATH=/ldc_standalone/ldc2-$LDC2_VER-linux-x86_64/bin:$PATH

VOLUME /prjct
WORKDIR /prjct

RUN mkdir /tmp/build

# libgcc, provides math lib
RUN $INST gcc-arm-none-eabi=15:13.2.rel1-2

# Path to libclang
ENV DFLAGS="-L=-L/usr/lib/llvm-16/lib/"

RUN dub fetch dpp@~master
RUN dub build dpp@~master

# Build Druntime & Phobos
RUN git clone --recurse-submodules https://github.com/denizzzka/dfruntime.git
ARG DR_BUILD=/tmp/build_druntime
ARG DR_INSTALL=/tmp/install_druntime
RUN meson setup -Dbuildtype=debug -Doptimization=s --prefix=$DR_INSTALL --cross-file meson/arm_cortex_m4_cross.ini $DR_BUILD dfruntime/
RUN ninja -C $DR_BUILD libdruntime-ldc-debug.a libphobos2-ldc-debug.a install

# Build result binary
ENTRYPOINT \
    meson setup --cross-file ../dfruntime/meson/arm_cortex_m4_cross.ini --cross-file arm_cortex_m4_cross.ini \
    -Doptimization=s -Ddebug=true \
    -Dldc2_conf=$DR_INSTALL/etc/ldc2_tagged.conf \
    /tmp/build && \
    ninja -j12 -C /tmp/build # If build fails try one-threaded build - workaround for https://github.com/denizzzka/d_c_arm_test/issues/2
