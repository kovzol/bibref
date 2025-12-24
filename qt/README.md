# Qt interface

This folder contains files to provide *bibref* with a [Qt](https://qt.io) interface. It is known to work with Qt 6.4 and above
(at the time of writing this, also with Qt 6.9).

## Translation steps

`lupdate -tr-function-alias QT_TRANSLATE_NOOP=TR mainwindow.cpp statementwindow.cpp editor.cpp -ts hu.ts` creates or updates the skeleton for the Hungarian translation.
Similarly to this way, it is possible to add translations for other languages (now, German is already included). Do not forget to update **bibref.qrc** in case.

## Building steps

See https://github.com/kovzol/bibref/wiki/Building-bibref for a recent step-by-step explanation.
For Linux, see also the flatpak scripts in this folder.

### Notes on Windows

On Windows, the SWORD library must be compiled and installed first. Use `clang++` (instead of `g++`) when
starting `cmake` via setting the environment variables `CC=clang` and `CXX=clang++`.
There may be issues with conversion errors when using SWORD 1.9.0 or below. In such cases, instead of using `(unsigned long)`,
the cast `(size_t)` can fix the compilation errors. In addition, **icu** requires the package `in`
for the moment (as of first half of 2024): it has to be added to the `cmake` configuration. See the `sword-patch-mingw64.diff` file
in the root folder of the *bibref* project for more details.

After building and installing SWORD in the folder `/mingw64`, you can start compiling **bibref-qt**.
Note that the current folder contains symbolic links. This may be unsupported in some
versions of Git under Windows. In such case, copying the source files from the root
folder may be a workaround. See also the steps in the GitHub Actions for more details.

When compiled on Wine (that is, not on native Windows), it is mandatory to use a proper version
of `FindRegex.cmake` during compiling SWORD. See the attached version in the `..` folder.
See also [a blog entry](https://matek.hu/zoltan/blog-20240822.php) for a step-by-step howto on this.

### Packaging on Windows

See the scripts `create-windows-folder`, `create-windows-zip` and `bibref.iss`
(this is an [Inno Setup](https://jrsoftware.org/isinfo.php) script) in the current folder.

More details can be found in `../RELEASING.md`.

## Running

Testing the translated texts is possible if you set the **LANG** environment variable before running the executable.

## Copyright

Breeze icons copyright KDE and licenced under the GNU LGPL version 3 or later.
