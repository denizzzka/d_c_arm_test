#!/usr/bin/env bash

# Creates D binding for ESP-IDF

set -euox pipefail

PATH_TO_PREPR=$1

# Do not forgot to init ESP IDF environment:
# $ source path/to/Espressif_IDE/esp-idf-v5.2.1/export.sh (.fish|.bat|.ps1)

echo "Preprocess *.h to *.i files by compiling of bogus C ESP IDF project"

PRESERVE_I_FILES=y idf.py --build-dir=preprocessed set-target esp32c3 build
FILES_LIST="preprocessed/preprocessed_files_list.txt"

echo "Prepare list of *.i files which will be used for binding creation"

fdfind --base-directory ${PATH_TO_PREPR} --type f --extension "c.i" \
    --case-sensitive \
    --ignore-file ../../d_binding_creation/fd_ignore.txt \
    --exec cp {} {.} \; \
    --exec sed -i -r 's/__atomic_/__atomic_DISABLED_/g' {.} \; \
    --exec sed -i -r 's/__sync_/REDECLARED__sync_/g' {.} \; \
    --exec echo ${PATH_TO_PREPR}/{.} \; > ${FILES_LIST}

# TODO: "restrict" in freertos isn't compatible with "__restrict" in esp_ringbuf, ESP IDF issue?

echo "Merging *.i files into D binding file"

D_BINDING_MODULE="./preprocessed/esp_idf_binding.d"
export D_BINDING=$(realpath $D_BINDING_MODULE)

dub fetch mc2d
time dub run mc2d --build=release -- \
    --clang_opts="--target=riscv32" \
    --threads=8 \
    --include=d_binding_creation/importc.h \
    --show_excluded=brief \
    --debug_output \
    --output ${D_BINDING_MODULE} < ${FILES_LIST} 2> preprocessed/d_binding_creation_err.log

# FIXME: unrecognized align
# Probably, this is same case as in https://github.com/atilaneves/dpp/issues/350
sed -i 's/align(1)://g' ${D_BINDING_MODULE}

echo "...Processing *.i files done"
