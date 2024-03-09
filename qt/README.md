# Qt interface

This folder contains files to provide *bibref* with a [Qt](https://qt.io) interface. It is known to work with Qt 6.2 and above.

## Translation steps

`lupdate -tr-function-alias QT_TRANSLATE_NOOP=TR mainwindow.cpp -ts hu.ts` creates or updates the skeleton for the Hungarian translation.

## Building on Linux

See the steps in the GitHub Actions (in `../.github`), or in the flatpak scripts in this folder.

## Building on Windows

**bibref-qt** can be compiled with MSYS2/MINGW64. Required packages are:

* mingw-w64-x86_64-boost
* mingw-w64-x86_64-clang
* mingw-w64-x86_64-cmake
* mingw-w64-x86_64-gcc
* mingw-w64-x86_64-make or mingw-w64-x86_64-ninja
* mingw-w64-x86_64-pkgconf
* mingw-w64-x86_64-qt6-base
* mingw-w64-x86_64-qt6-translations
* mingw-w64-x86_64-readline
* mingw-w64-x86_64-zlib

The SWORD library must be compiled and installed first. Use clang++ (instead of g++) when
starting cmake via setting the environment variables CC=clang and CXX=clang++.
There may be issues with conversion errors. In such cases, instead of using `(unsigned int)`,
the cast `(size_t)` can fix the compilation errors.
There are about 20 occurrences of this type of problem in SWORD version 1.9.0.

Also, the Windows build assumes that the icu, lzma, zlib and bzip2 libraries are present.
These should be available via other packages, but if not, they must be installed first.

Note that the current folder contains symbolic links. This may be unsupported in some
versions of Git under Windows. In such case, copying the source files from the root
folder may be a workaround.

## Minor issues

Currently, the path to translation files (*.qm) and the bibref logo are hardcoded
in main.cpp and mainwindow.cpp. Therefore, these files should be present if
for the localization and to show the application icon properly.
