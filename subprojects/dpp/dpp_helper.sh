#!/bin/sh

set -e

INPUT_FILE="$1"
COPIED_FILE="$2"

shift 2

cp "$INPUT_FILE" "$COPIED_FILE"
dub run dpp -- "$@" "$COPIED_FILE"
