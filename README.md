# inksi-lcms2

> [Little-CMS 2.19](https://github.com/mm2/Little-CMS) fork for the [Inksi](https://github.com/belon) printing SDK cross-platform build pipeline.

## Purpose

Prebuilt static libraries for:

| Platform | Arch       | Release artifact                |
|----------|------------|---------------------------------|
| Android  | arm64-v8a  | `lcms2-android-arm64-v8a.a`     |
| iOS      | arm64      | `lcms2-ios-arm64.a`             |
| macOS    | universal  | `lcms2-macos-universal.a`       |
| Windows  | x86_64     | `lcms2-windows-x86_64.lib`      |
| Linux    | x86_64     | `lcms2-linux-x86_64.a`          |
| OHOS     | arm64-v8a  | `lcms2-ohos-arm64-v8a.a`        |

## Build

### GitHub Actions (CI)

Tag a `v*` release to trigger all 5 platform builds automatically.

### Local build

```bash
# Android
./scripts/build-android.sh

# iOS
./scripts/build-ios.sh

# macOS (native arch)
./scripts/build-macos.sh

# Linux
./scripts/build-linux.sh

# Windows
scripts\build-windows.bat

# OHOS (requires DevEco Studio)
./scripts/build-ohos.sh
```

Or manually:

```bash
mkdir build && cd build
cmake .. \
  -DLCMS2_BUILD_SHARED=OFF \
  -DLCMS2_BUILD_STATIC=ON \
  -DLCMS2_BUILD_TOOLS=OFF \
  -DLCMS2_BUILD_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=Release
cmake --build . -j
```

## License

MIT — same as upstream Little-CMS.
