#!/bin/bash
set -euo pipefail

# ============================================================
# Android 编译脚本（macOS/Linux）
# 产物: lcms2-android-arm64-v8a.a
# ============================================================
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 查找 NDK
if [ -z "${ANDROID_NDK_HOME:-}" ]; then
    if [ -d "$HOME/Library/Android/sdk/ndk" ]; then
        ANDROID_NDK_HOME=$(ls -d "$HOME/Library/Android/sdk/ndk"/*/ 2>/dev/null | sort -V | tail -1)
    elif [ -d "$HOME/Android/Sdk/ndk" ]; then
        ANDROID_NDK_HOME=$(ls -d "$HOME/Android/Sdk/ndk"/*/ 2>/dev/null | sort -V | tail -1)
    fi
fi
if [ -z "${ANDROID_NDK_HOME:-}" ]; then
    echo "Error: ANDROID_NDK_HOME not set"
    exit 1
fi
TOOLCHAIN="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake"
echo "NDK: $ANDROID_NDK_HOME"

# 编译
mkdir -p "$SCRIPT_DIR/build-android"
cd "$SCRIPT_DIR/build-android"
cmake "$SCRIPT_DIR" \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-21 \
    -DLCMS2_BUILD_SHARED=OFF \
    -DLCMS2_BUILD_STATIC=ON \
    -DLCMS2_BUILD_TOOLS=OFF \
    -DLCMS2_BUILD_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=Release
cmake --build . -j"$(sysctl -n hw.ncpu 2>/dev/null || nproc)"

cp liblcms2.a "$SCRIPT_DIR/lcms2-android-arm64-v8a.a"
echo "Done: $SCRIPT_DIR/lcms2-android-arm64-v8a.a ($(du -h "$SCRIPT_DIR/lcms2-android-arm64-v8a.a" | cut -f1))"
