FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade

ARG INST="apt-get install --no-install-recommends -y"

RUN $INST build-essential clang libclang-dev gcc-arm-none-eabi
RUN $INST python3 python3-setuptools python3-wheel
RUN $INST pipx
RUN $INST git ninja-build
RUN $INST wget ca-certificates
RUN $INST lld llvm

# Install meson
ENV PATH=$PATH:/root/.local/bin
RUN pipx install meson

# Install ldc2
RUN wget -qO ldc2.tar.xz https://github.com/ldc-developers/ldc/releases/download/v1.37.0/ldc2-1.37.0-linux-x86_64.tar.xz
RUN mkdir /ldc_standalone
RUN tar xf ldc2.tar.xz -C /ldc_standalone
ENV PATH=/ldc_standalone/ldc2-1.37.0-linux-x86_64/bin:$PATH

VOLUME /prjct
WORKDIR /prjct

# Compile
ENV DFLAGS="-L=-L/usr/lib/llvm-14/lib/"
RUN mkdir /tmp/build

ENTRYPOINT \
    meson setup --cross-file arm_cortex_m4_cross.ini -Doptimization=s -Ddebug=true /tmp/build && \
    ninja -j1 -C /tmp/build # One threaded build - workaround for https://github.com/denizzzka/d_c_arm_test/issues/2
