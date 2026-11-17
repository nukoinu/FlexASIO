# FlexASIO Developer Information

[![.github/workflows/continuous-integration.yml](https://github.com/dechamps/FlexASIO/actions/workflows/continuous-integration.yml/badge.svg)](https://github.com/dechamps/FlexASIO/actions/workflows/continuous-integration.yml)

See `LICENSE.txt` for licensing information. In particular, do note that
specific license terms apply to the ASIO trademark and ASIO SDK.

## Building

FlexASIO is designed to be built using CMake within the Microsoft Visual C++
2019/2022 toolchain native CMake support.

FlexASIO uses a CMake "superbuild" system (in `/src`) to automatically build the
dependencies (most notably [PortAudio][]) before building FlexASIO itself. These
dependencies are pulled in as git submodules.

It is strongly recommended to use the superbuild system. Providing dependencies
manually is quite tedious because FlexASIO uses a highly modular structure that
relies on many small subprojects.

Note that the ASIOUtil build system will download the [ASIO SDK][] for you
automatically at configure time.

### x64 build with WASAPI and WDM-KS

Install the Visual Studio C++ desktop tools, including ATL and a Windows SDK,
and make Python available on `PATH` for the libsndfile build. From an x64
Visual Studio developer shell, run these commands at the repository root:

```powershell
git submodule update --init --recursive
$env:CMAKE_POLICY_VERSION_MINIMUM = '3.5' # For the pinned dependencies with CMake 4
cmake -S src -B src/out/build/x64-wasapi-wdmks -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo "-DCMAKE_INSTALL_PREFIX=$PWD/src/out/install/x64-wasapi-wdmks" -DFLEXASIO_WASAPI_WDMKS_ONLY=ON
cmake --build src/out/build/x64-wasapi-wdmks
cmake --install src/out/build/x64-wasapi-wdmks
```

This build defaults to WASAPI shared mode. An existing `FlexASIO.toml` that
explicitly selects DirectSound or MME must select an available backend, such
as `backend = "Windows WASAPI"`. For an x64 baseline build, use a separate
build directory and set `FLEXASIO_WASAPI_WDMKS_ONLY=OFF`.

The staged `bin` directory contains `FlexASIOTest.exe` for testing the local
DLL directly and `PortAudioDevices.exe` for checking the available backends.
PDB files can be kept separately when copying or archiving the binaries.

## Packaging

For the x64 WASAPI and WDM-KS package, add `-DFLEXASIO_RELEASE_VERSION=1.20`
to the CMake configure command above, then build and stage the binaries. From
the repository root, run the following with Inno Setup 6.3 or later available.

```powershell
cmake -DFLEXASIO_X64_BUILD_DIR=src/out/build/x64-wasapi-wdmks -P src/installer.cmake
```

The installer in `src/out/installer` uses the release version from the build
cache. `-DInnoSetup_iscc_EXECUTABLE=<path>` can supply a portable compiler.

The following command will generate the installer package for you:

```
cmake -P installer.cmake
```

Note that for this command to work:

 -  You need to have [Inno Setup][] installed.
 -  You need to have built FlexASIO in the `x64-Release` and `x86-Release`
    Visual Studio configurations first.

**Note:** instead of running `installer.cmake` manually, it is often preferable
to let the FlexASIO GitHub Actions workflow build the installer, as that
guarantees a clean build.

## Troubleshooting

### VC runtime DLLs are not included in the installation

See this [Visual Studio 2019 bug][InstallRequiredSystemLibraries].

---

*ASIO is a trademark and software of Steinberg Media Technologies GmbH*

[ASIO SDK]: http://www.steinberg.net/en/company/developer.html
[Inno Setup]: http://www.jrsoftware.org/isdl.php
[InstallRequiredSystemLibraries]: https://developercommunity.visualstudio.com/content/problem/618084/cmake-installrequiredsystemlibraries-broken-in-lat.html
[PortAudio]: http://www.portaudio.com/
[tinytoml]: https://github.com/mayah/tinytoml
