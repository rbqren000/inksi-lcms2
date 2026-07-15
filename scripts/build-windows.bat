@echo off
REM ============================================================
REM Windows 编译脚本（仅 Windows）
REM 依赖: CMake, Visual Studio 2022+
REM 产物: lcms2-windows-x86_64.lib
REM ============================================================
setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0..

echo Building lcms2 for Windows x86_64...
if not exist "%SCRIPT_DIR%\build-windows" mkdir "%SCRIPT_DIR%\build-windows"
cd /d "%SCRIPT_DIR%\build-windows"
cmake "%SCRIPT_DIR%" ^
    -DLCMS2_BUILD_SHARED=OFF ^
    -DLCMS2_BUILD_STATIC=ON ^
    -DLCMS2_BUILD_TOOLS=OFF ^
    -DLCMS2_BUILD_TESTS=OFF ^
    -DCMAKE_BUILD_TYPE=Release
if !errorlevel! neq 0 exit /b !errorlevel!
cmake --build . --config Release -j
if !errorlevel! neq 0 exit /b !errorlevel!

copy /y Release\lcms2.lib "%SCRIPT_DIR%\lcms2-windows-x86_64.lib"
echo Done: %SCRIPT_DIR%\lcms2-windows-x86_64.lib
