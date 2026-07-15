# inksi-lcms2

> [Little-CMS 2.19](https://github.com/mm2/Little-CMS) fork for the [Inksi](https://github.com/belon) printing SDK cross-platform build pipeline.

## Purpose

Prebuilt static libraries for:

| Platform | Arch       | Output         |
|----------|------------|----------------|
| Android  | arm64-v8a  | `liblcms2.a`   |
| iOS      | arm64      | `liblcms2.a`   |
| macOS    | universal  | `liblcms2.a`   |
| Windows  | x86_64     | `lcms2.lib`    |
| Linux    | x86_64     | `liblcms2.a`   |

## Build

All platforms are compiled via GitHub Actions. See `.github/workflows/`.

### Local build (any platform)

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
