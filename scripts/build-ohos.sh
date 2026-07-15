#!/bin/bash
set -euo pipefail

# ============================================================
# OHOS（鸿蒙）编译脚本（macOS/Windows/Linux，需 DevEco NDK）
# 产物: lcms2-ohos-arm64-v8a.a
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 查找 OHOS NDK
OHOS_NDK="${OHOS_NDK_HOME:-}"
if [ -z "$OHOS_NDK" ]; then
    for p in \
        "/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/native" \
        "$HOME/Library/Huawei/DevEcoStudio/sdk/default/openharmony/native"; do
        if [ -f "$p/build/cmake/ohos.toolchain.cmake" ]; then
            OHOS_NDK="$p"
            break
        fi
    done
fi
TOOLCHAIN="$OHOS_NDK/build/cmake/ohos.toolchain.cmake"
if [ ! -f "$TOOLCHAIN" ]; then
    echo "Error: OHOS NDK not found. Set OHOS_NDK_HOME or install DevEco Studio."
    exit 1
fi
echo "OHOS NDK: $OHOS_NDK"

mkdir -p "$SCRIPT_DIR/build-ohos"
cd "$SCRIPT_DIR/build-ohos"
cmake "$SCRIPT_DIR" \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" \
    -DOHOS_ARCH=arm64-v8a \
    -DLCMS2_BUILD_SHARED=OFF \
    -DLCMS2_BUILD_STATIC=ON \
    -DLCMS2_BUILD_TOOLS=OFF \
    -DLCMS2_BUILD_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=Release
cmake --build . -j"$(sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4)"

cp liblcms2.a "$SCRIPT_DIR/lcms2-ohos-arm64-v8a.a"
echo "Done: $SCRIPT_DIR/lcms2-ohos-arm64-v8a.a ($(du -h "$SCRIPT_DIR/lcms2-ohos-arm64-v8a.a" | cut -f1))"
