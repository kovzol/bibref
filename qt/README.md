# Qt interface

This folder contains files to provide *bibref* with a [Qt](https://qt.io) interface. It is known to work with Qt 6.2 and above.

## Translation steps

`lupdate -tr-function-alias QT_TRANSLATE_NOOP=TR mainwindow.cpp -ts hu.ts` creates or updates the skeleton for the Hungarian translation.

## Building on Linux

See the steps in the GitHub Actions (in `../.github`), or in the flatpak scripts in this folder.

## Building on Windows

**bibref-qt** can be compiled with MSYS2/MINGW64. Required packages are:

* mingw-w64-x86_64-gcc
* mingw-w64-x86_64-make or mingw-w64-x86_64-ninja
* mingw-w64-x86_64-cmake
* mingw-w64-x86_64-pkgconf
* mingw-w64-x86_64-boost
* mingw-w64-x86_64-clang
* mingw-w64-x86_64-qt6-base
* mingw-w64-x86_64-qt6-tools
* mingw-w64-x86_64-qt6-translations
* mingw-w64-x86_64-readline
* mingw-w64-x86_64-zlib

The SWORD library must be compiled and installed first. Use clang++ (instead of g++) when
starting cmake via setting the environment variables CC=clang and CXX=clang++.
There may be issues with conversion errors. In such cases, instead of using `(unsigned long)`,
the cast `(size_t)` can fix the compilation errors. In addition, icu requires the package `in`
for the moment: it has to be added to the cmake configuration. See the `sword-patch-mingw64.diff` file
in the root folder of the bibref project for more details.

Note that the current folder contains symbolic links. This may be unsupported in some
versions of Git under Windows. In such case, copying the source files from the root
folder may be a workaround.

See also the steps in the GitHub Actions for more details.

### Packaging

See the scripts `create-windows-folder`, `create-windows-zip` and `bibref.iss`
(this is an [Inno Setup](https://jrsoftware.org/isinfo.php) script) in the current folder.
