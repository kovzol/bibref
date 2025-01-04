# Qt interface

This folder contains files to provide *bibref* with a [Qt](https://qt.io) interface. It is known to work with Qt 6.4 and above
(at the time of writing this, also with Qt 6.8).

## Translation steps

`lupdate -tr-function-alias QT_TRANSLATE_NOOP=TR mainwindow.cpp statementwindow.cpp -ts hu.ts` creates or updates the skeleton for the Hungarian translation.
Similarly to this way, it is possible to add translations for other languages.

## Building on Linux

See the steps in the GitHub Actions (in `../.github/workflow/build.yml`), or in the flatpak scripts in this folder.

## Building on Windows

For reference, you should have a look at the steps in the GitHub Actions (in `../.github/workflow/build.yml`).

**bibref-qt** can be compiled with MSYS2/MINGW64 on native Windows or on [Wine](https://github.com/msys2/MSYS2-packages/issues/682#issuecomment-1836544182).
The required MSYS2 packages are:

* `mingw-w64-x86_64-gcc`
* `mingw-w64-x86_64-make` or `mingw-w64-x86_64-ninja`
* `mingw-w64-x86_64-cmake`
* `mingw-w64-x86_64-pkgconf`
* `mingw-w64-x86_64-boost`
* `mingw-w64-x86_64-clang`
* `mingw-w64-x86_64-qt6-base`
* `mingw-w64-x86_64-qt6-tools`
* `mingw-w64-x86_64-qt6-translations`
* `mingw-w64-x86_64-readline`
* `mingw-w64-x86_64-zlib`
* `mingw-w64-x86_64-qt6-svg`
* `mingw-w64-x86_64-graphviz`

The last two ones are only required if you want to have statement analysis support in
the **Statement Editor** (which can be started from the **Quotation** menu), in its **Prove** menu,
after a successful run of **Parse**.

If you want to create a package from **bibref-qt** (see below), you need additionally:

* `mingw-w64-x86_64-ntldd`
* `unzip`
* `zip`

The SWORD library must be compiled and installed first. Use `clang++` (instead of `g++`) when
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

### Packaging

See the scripts `create-windows-folder`, `create-windows-zip` and `bibref.iss`
(this is an [Inno Setup](https://jrsoftware.org/isinfo.php) script) in the current folder.

In particular, you need to build the executable `bibref-qt.exe` first by
issuing e.g. `mkdir build; cd build; CC=clang CXX=clang++ cmake -G Ninja ..; ninja`
in an MSYS2/MINGW64 environment (see above,
in case you decide to use Ninja instead of GNU Make), then run
`./bibref-qt.exe` in the same environment to test if the executable starts properly, then quit.
Then, issue `cd ..; ./create-windows-folder build -f` (this creates a minimal but incomplete portable version in a new folder
called something like `bibref-qt-2024Mar30`),
and then `cd bibref-qt-2024Mar30; ./start.bat` in the newly created folder (this starts the program, it should
work also in a non-MINGW64 environment), finally, save the addbooks cache by
selecting **File > Add books** and run `mv bibref-addbooks-cache ../build; cd ..; rm -fr bibref-qt-2024Mar30; ./create-windows-folder build` to obtain all
required files in the target folder. Finally, you can use `./create-windows-zip` to create a
portable `.zip` file.

### Running

Once you created the folder `bibref-qt-2024Mar30` properly, just run the program by starting `start.bat`.
It is assumed that the SWORD modules are installed in the current user's home directory in the folder `.sword`.
To learn more about **bibref-qt**, you will find further information in the **Help** menu.

Testing the translated texts is possible if you set the **LANG** environment variable before running the executable.
