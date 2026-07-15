#!/bin/bash
set -euo pipefail

# ============================================================
# Linux 编译脚本（仅 Linux）
# 产物: lcms2-linux-x86_64.a
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ "$(uname)" != "Linux" ]; then
    echo "Error: this script must be run on Linux"
    exit 1
fi

mkdir -p "$SCRIPT_DIR/build-linux"
cd "$SCRIPT_DIR/build-linux"
cmake "$SCRIPT_DIR" \
    -DLCMS2_BUILD_SHARED=OFF \
    -DLCMS2_BUILD_STATIC=ON \
    -DLCMS2_BUILD_TOOLS=OFF \
    -DLCMS2_BUILD_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=Release
cmake --build . -j"$(nproc)"

cp liblcms2.a "$SCRIPT_DIR/lcms2-linux-x86_64.a"
echo "Done: $SCRIPT_DIR/lcms2-linux-x86_64.a ($(du -h "$SCRIPT_DIR/lcms2-linux-x86_64.a" | cut -f1))"
