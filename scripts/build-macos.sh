#!/bin/bash
set -euo pipefail

# ============================================================
# macOS 编译脚本（仅 macOS）
# 编译本机架构（arm64 或 x86_64）
# 如需 universal 产物，手动对两个架构产物执行 lipo
# 产物: lcms2-macos-{arch}.a
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ "$(uname)" != "Darwin" ]; then
    echo "Error: macOS build requires macOS"
    exit 1
fi

ARCH=$(uname -m)
echo "Host architecture: $ARCH"

mkdir -p "$SCRIPT_DIR/build-macos-$ARCH"
cd "$SCRIPT_DIR/build-macos-$ARCH"
cmake "$SCRIPT_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="$ARCH" \
    -DLCMS2_BUILD_SHARED=OFF \
    -DLCMS2_BUILD_STATIC=ON \
    -DLCMS2_BUILD_TOOLS=OFF \
    -DLCMS2_BUILD_TESTS=OFF
cmake --build . -j"$(sysctl -n hw.ncpu)"

cp liblcms2.a "$SCRIPT_DIR/lcms2-macos-${ARCH}.a"
echo "Done: $SCRIPT_DIR/lcms2-macos-${ARCH}.a ($(du -h "$SCRIPT_DIR/lcms2-macos-${ARCH}.a" | cut -f1))"
