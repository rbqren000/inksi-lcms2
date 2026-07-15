#!/bin/bash
set -euo pipefail

# ============================================================
# iOS 编译脚本（仅 macOS）
# 产物: liblcms2-ios-arm64.a
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ "$(uname)" != "Darwin" ]; then
    echo "Error: iOS build requires macOS"
    exit 1
fi

mkdir -p "$SCRIPT_DIR/build-ios"
cd "$SCRIPT_DIR/build-ios"
cmake "$SCRIPT_DIR" \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES=arm64 \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=13.0 \
    -DLCMS2_BUILD_SHARED=OFF \
    -DLCMS2_BUILD_STATIC=ON \
    -DLCMS2_BUILD_TOOLS=OFF \
    -DLCMS2_BUILD_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=Release
cmake --build . -j"$(sysctl -n hw.ncpu)"

cp liblcms2.a "$SCRIPT_DIR/liblcms2-ios-arm64.a"
echo "Done: $SCRIPT_DIR/liblcms2-ios-arm64.a ($(du -h "$SCRIPT_DIR/liblcms2-ios-arm64.a" | cut -f1))"
