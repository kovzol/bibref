# This file makes it easier to compile the Windows version of bibref (the GUI version)
# in a Docker virtualization in a Linux guest. Cross-compilation is performed with the Linux
# version of MINGW64. Most dependencies are provided by the MSYS2/MINGW64 packages,
# except for Qt6 (which is compiled twice: first for Linux, then for Linux/MINGW64), SWORD, and for bibref-qt.
# Warning: You need about about 76 GB of disk space to create the Docker image, and several hours
# of downloading (please use a stable Internet connection) and reasonable compilation time to make everything work.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build -f Dockerfile .`.
#    You will get an image ID at the end of the process.
# 3. Run the image by typing `sudo docker run ID`.
# 4. Run `sudo docker ps -a | head -2` to find out the container identifier CID as output.
# 5. Copy the finished folder with the executable and the required DLLs and extra files by entering
#    `sudo docker cp CID:/build/dist FOLDER` in an arbitrary FOLDER.
# 6. To test the Windows version on Linux, change the working directory to FOLDER and
#    type `wine bibref-qt.exe`.
# 7. If no longer used, you can remove the Docker container and image by entering
#    `sudo docker rm CID` and `sudo docker rmi ID`.


# 1. Get prerequisites and cross compiling tools:
FROM debian:trixie
RUN apt-get update && apt-get install -y \
    build-essential cmake git wget unzip xz-utils zstd pkg-config \
    mingw-w64 mingw-w64-tools g++-mingw-w64-x86-64 \
    flex bison autoconf automake libtool \
    qt6-base-dev qt6-tools-dev qt6-base-dev-tools \
    perl python3 ninja-build libdbus-1-dev \
    libsword-common libsword-dev \
    libreadline-dev libboost-dev libboost-filesystem-dev

# 2. Create toolchain file for cmake (it will be used to cross-compile SWORD and bibref-qt for Windows):
WORKDIR /build
RUN echo "set(CMAKE_SYSTEM_NAME Windows)\n\
    set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)\n\
    set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)\n\
    set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)\n\
    set(CMAKE_FIND_ROOT_PATH /opt/mingw64)\n\
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)\n\
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)\n\
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)" \
        > /build/toolchain-mingw64.cmake

# 3. Download bibref and SWORD:
RUN git clone --depth=1 https://github.com/kovzol/bibref.git
RUN wget -q https://www.crosswire.org/ftpmirror/pub/sword/source/v1.9/sword-1.9.0.tar.gz
RUN tar xzf sword-1.9.0.tar.gz

# 4. Cross-compile SWORD for Windows via Linux/MINGW64:
WORKDIR /build
RUN mkdir orig
RUN mv sword-1.9.0 orig
WORKDIR orig
RUN patch -i ../bibref/sword-patch-mingw64.diff -p1
RUN cp ../bibref/FindRegex.cmake sword-1.9.0/cmake
RUN sed -i 's/2.6.0/3.5.0/' sword-1.9.0/CMakeLists.txt
WORKDIR sword-1.9.0
RUN mkdir build
WORKDIR build
RUN cmake .. \
        -DCMAKE_TOOLCHAIN_FILE=/build/toolchain-mingw64.cmake \
        -DCMAKE_INSTALL_PREFIX=/opt/mingw64 \
        -DCMAKE_BUILD_TYPE=Release \
        -DWITH_CURL=No -DLIBSWORD_LIBRARY_TYPE=Static \
        -DSWORD_BUILD_UTILS=No -DSWORD_BUILD_EXAMPLES=No \
        -DCMAKE_CXX_FLAGS="-fpermissive"
RUN make -j$(nproc) sword_static
RUN make install

# 5. Build Qt for Windows via Linux/MINGW64:
## 5/1. Clone repository...
WORKDIR /build
ENV QT6_VERSION=6.10.0
RUN git clone git://code.qt.io/qt/qt5.git qt6
WORKDIR qt6
RUN git switch $QT6_VERSION
RUN perl init-repository
## 5/2. Compile Qt for the Linux host...
WORKDIR ..
RUN mkdir qt6-host-build
WORKDIR qt6-host-build
RUN ../qt6/configure -prefix /opt/qt6-host -opensource -confirm-license -nomake examples -nomake tests
RUN cmake --build . -j$(nproc)
RUN cmake --install .
## 5/3. Cross-compile Qt for Windows...
WORKDIR ..
RUN mkdir qt6-mingw-build
WORKDIR qt6-mingw-build
ENV CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++ \
    AR=x86_64-w64-mingw32-ar \
    RANLIB=x86_64-w64-mingw32-ranlib \
    STRIP=x86_64-w64-mingw32-strip
RUN ../qt6/configure \
        -prefix /opt/qt6-mingw64 -xplatform win32-g++ \
        -opensource -confirm-license \
        -shared \
        -nomake examples -nomake tests \
        -skip qtactiveqt -skip qtshadertools -skip qtlanguageserver \
        -skip qtquick3d -skip qtmultimedia -skip qtgraphs -skip qtquick3dphysics \
        -skip qtquickeffectmaker -skip qtspeech \
        -skip qtlottie -skip qtwebview -skip qtwebengine \
        -skip qtqmltoolingsettings -skip QtQmlToolingSettingsPrivate \
        -qt-host-path /opt/qt6-host \
        -cmake-generator Ninja -- \
        -DCMAKE_SYSTEM_NAME=Windows \
        -DCMAKE_SYSROOT=/usr/x86_64-w64-mingw32 \
        -DCMAKE_FIND_ROOT_PATH=/usr/x86_64-w64-mingw32 \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
RUN cmake --build . -j$(nproc) -t qtbase -t qttools -t qtsvg -t qtimageformats
RUN cmake --install qtbase
RUN cmake --install . --component tools
RUN cmake --install . --component qml
RUN cmake --install . --component libraries

# 6. Download MSYS2/MINGW64 packages:
WORKDIR /build
ARG MSYS2_MIRROR=https://repo.msys2.org/mingw/mingw64
ARG MSYS2_BOOST_VERSION=1.90.0-1 \
    MSYS2_BOOST_LIBS_VERSION=1.90.0-1 \
    MSYS2_BROTLI_VERSION=1.2.0-1 \
    MSYS2_BZIP2_VERSION=1.0.8-3 \
    MSYS2_CAIRO_VERSION=1.18.4-4 \
    MSYS2_EXPAT_VERSION=2.7.3-1 \
    MSYS2_FONTCONFIG_VERSION=2.17.1-1 \
    MSYS2_FREETYPE_VERSION=2.14.1-2 \
    MSYS2_FRIBIDI_VERSION=1.0.16-1 \
    MSYS2_GDK_PIXBUF2_VERSION=2.44.4-1 \
    MSYS2_GETTEXT_VERSION=0.22.4-3 \
    MSYS2_GLIB2_VERSION=2.86.3-1 \
    MSYS2_GRAPHITE2_VERSION=1.3.14-3 \
    MSYS2_GRAPHVIZ_VERSION=14.1.1-1 \
    MSYS2_HARFBUZZ_VERSION=12.3.0-1 \
    MSYS2_JBIGKIT_VERSION=2.1-5 \
    MSYS2_PANGO_VERSION=1.56.4-3 \
    MSYS2_LERC_VERSION=4.0.0-1 \
    MSYS2_LIBDATRIE_VERSION=0.2.14-1 \
    MSYS2_LIBDEFLATE_VERSION=1.25-1 \
    MSYS2_LIBFFI_VERSION=3.5.2-1 \
    MSYS2_LIBICONV_VERSION=1.18-1 \
    MSYS2_LIBJPEG_TURBO_VERSION=3.1.3-1 \
    MSYS2_LIBLTDL_VERSION=2.5.4-3 \
    MSYS2_LIBPNG_VERSION=1.6.53-1 \
    MSYS2_LIBRSVG_VERSION=2.61.3-1 \
    MSYS2_LIBTHAI_VERSION=0.1.29-3 \
    MSYS2_LIBTIFF_VERSION=4.7.1-1 \
    MSYS2_LIBWEBP_VERSION=1.6.0-1 \
    MSYS2_LIBWINPTHREAD_VERSION=13.0.0.r91.gfc0b67305-1 \
    MSYS2_LIBXML2_VERSION=2.15.1-2 \
    MSYS2_PCRE2_VERSION=10.47-1 \
    MSYS2_PIXMAN_VERSION=0.46.4-1 \
    MSYS2_XZ_VERSION=5.8.2-1 \
    MSYS2_ZSTD_VERSION=1.5.7-1 \
    MSYS2_ZLIB_VERSION=1.3.1-1
ENV DEST=/opt
RUN set | grep ^MSYS2_ | grep _VERSION= | while read SETTING; do \
        PACKAGE=`echo $SETTING | cut -d= -f1 | sed s/MSYS2_// | sed s/_VERSION// | tr _ - | awk '{print tolower($0)}'`; \
        VERSION=`echo $SETTING | cut -d= -f2 | sed s/"'"//g`; \
        FILENAME=mingw-w64-x86_64-$PACKAGE-$VERSION-any.pkg.tar.zst; \
        wget -q -N $MSYS2_MIRROR/$FILENAME; \
        tar x --zstd -f $FILENAME -C /opt; \
        echo $FILENAME; \
    done

# 7. Build bibref-qt:
ENV CC= \
    CXX= \
    AR= \
    RANLIB= \
    STRIP=
WORKDIR /build/bibref/qt
## 7/1. Prepare cmake configuration by removing bzip2, liblzma and icu...
RUN sed -i '/find_package(Boost/ s/\(\bCOMPONENTS\b[^(]*\) system/\1/' CMakeLists.txt
RUN sed -i '/^[[:space:]]*find_package[[:space:]]*(BZip2[[:space:]]\+REQUIRED[[:space:]]*)[[:space:]]*$/d' CMakeLists.txt
RUN sed -i '/^[[:space:]]*find_package[[:space:]]*(LibLZMA[[:space:]]\+REQUIRED[[:space:]]*)[[:space:]]*$/d' CMakeLists.txt
RUN sed -i '/^[[:space:]]*find_package[[:space:]]*(ICU[[:space:]]\+REQUIRED[[:space:]]\+uc[[:space:]]\+in[[:space:]]*)[[:space:]]*$/d' CMakeLists.txt
## 7/2. Add embedded files (icons, translations) in the executable...
RUN sed -i 's/^[[:space:]]*set[[:space:]]*(BIBREF_QRC_EXTRA[[:space:]]*""[[:space:]]*)/set(BIBREF_QRC_EXTRA "bibref-wasm.qrc")\nqt6_add_translation(QTBASE_QM_FILES ${QTBASE_TRANSLATION_FILES})/' CMakeLists.txt
## 7/3. Patch main.cpp...
WORKDIR /build/bibref
RUN echo "diff --git a/qt/main.cpp b/qt/main.cpp\n\
index c1e37c5..1b58fd6 100644\n\
--- a/qt/main.cpp\n\
+++ b/qt/main.cpp\n\
@@ -157,32 +157,13 @@ void setLanguage(QString language)\n\
         qApp->installTranslator(&qtTranslator);\n\
     }\n\
\n\
-#ifndef __EMSCRIPTEN__\n\
-    if (qtBaseTranslator.load(\"qtbase_\" + language,\n\
-                              QLibraryInfo::path(QLibraryInfo::TranslationsPath))) {\n\
-        qApp->installTranslator(&qtBaseTranslator);\n\
-    }\n\
-#endif\n\
-\n\
     QString qmDir;\n\
-#ifdef __EMSCRIPTEN__\n\
     qmDir = \":/\";\n\
-#else\n\
-    if (std::filesystem::exists(PROJECT_SOURCE_DIR \"/hu.qm\"))\n\
-        qmDir = PROJECT_SOURCE_DIR; // This must be set externally, currently done via cmake\n\
-    else if (std::filesystem::exists(INSTALL_PREFIX \"/\" SHARE_FOLDER \"/hu.qm\"))\n\
-        qmDir = INSTALL_PREFIX // This must be set externally, currently done via cmake\n\
-            \"/\" SHARE_FOLDER;\n\
-    else\n\
-        qmDir = SHARE_FOLDER; // for relative path (when extracted from a .zip)\n\
-#endif\n\
     if (bibrefTranslator.load(language, qmDir)) {\n\
         qApp->installTranslator(&bibrefTranslator);\n\
     }\n\
-#ifdef __EMSCRIPTEN__\n\
     if (qtBaseTranslator.load(\"qtbase_\" + language, qmDir)) {\n\
         qApp->installTranslator(&qtBaseTranslator);\n\
     }\n\
-#endif\n\
     // FIXME: the last item should be inserted in a simpler and more flexible way.\n\
 }\n" > qt/main.cpp.diff
RUN patch --verbose -p1 < qt/main.cpp.diff
## 7/4. Configure cross-compiling and build...
WORKDIR /build/bibref/qt
RUN mkdir build
WORKDIR build
RUN cmake .. -G Ninja \
        -DCMAKE_TOOLCHAIN_FILE=/build/toolchain-mingw64.cmake \
        -DCMAKE_INSTALL_PREFIX=/opt/mingw64 \
        -DWEBENGINE=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH="/build/qt6-mingw-build/qtbase/lib/cmake;/opt/mingw64;/opt/mingw64/lib/cmake;/opt/mingw64/lib" \
        -DBOOST_ROOT=/opt/mingw64 \
        -DBoost_USE_STATIC_LIBS=ON \
        -DBoost_USE_MULTITHREADED=ON \
        -DCMAKE_POLICY_DEFAULT_CMP0144=NEW \
        -DCMAKE_EXE_LINKER_FLAGS="-L/opt/mingw64/lib"
RUN ninja -j$(nproc)
RUN ninja install || true

# 8. Build bibref for Linux (cli) and create bibref-addbooks-cache:
## 8/1. Build bibref for Linux (cli)...
WORKDIR /build/bibref
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make -j$(nproc)
RUN make install || true
## 8/2. Create the addbooks-cache...
RUN bibref -a

# 9. Create Windows folder with all required files:
WORKDIR /build
RUN mkdir dist
# 9/1. Collect MSYS2/MINGW64 DLLs (this may change when versions change)...
ARG MSYS2_MINGW64_DLLS="libboost_filesystem-mt libbrotlicommon libbrotlidec \
    libbrotlienc libbz2-1 libcairo-2 libcairo-gobject-2 \
    libcdt-6 libcgraph-8 libdatrie-1 libdeflate \
    libexpat-1 libffi-8 libfontconfig-1 libfreetype-6 \
    libfribidi-0 libgdk_pixbuf-2.0-0 \
    libgio-2.0-0 libglib-2.0-0 libgmodule-2.0-0 \
    libgobject-2.0-0 libgraphite2 libgvc-7 \
    libgvplugin_core-8 libgvplugin_dot_layout-8 \
    libgvplugin_pango-8 libgvplugin_rsvg-8 libharfbuzz-0 \
    libiconv-2 libintl-8 libjbig-0 libjpeg-8 libLerc \
    libltdl-7 liblzma-5 libpango-1.0-0 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libpangowin32-1.0-0 libpathplan-4 \
    libpcre2-8-0 libpixman-1-0 libpng16-16 libwinpthread-1 librsvg-2-2 \
    libsharpyuv-0 libthai-0 libtiff-6 \
    libwebp-7 libxdot-4 libxml2-16 libzstd"
RUN for i in $MSYS2_MINGW64_DLLS; do \
        DLL=`find /opt -name $i.dll | head -1`; \
        echo $DLL; \
        cp $DLL /build/dist; \
        done
# 9/2. Collect runtimes from cross compiler...
ARG LINUX_MINGW64_DLLS="libgcc_s_seh-1 libstdc++-6"
RUN for i in $LINUX_MINGW64_DLLS; do \
        DLL=`find /usr/lib/gcc/x86_64-w64-mingw32 -name $i.dll | grep win32 | head -1`; \
        echo $DLL; \
        cp $DLL /build/dist; \
        done
# 9/3. Collect Qt DLLs (some of them take place in the build folder)...
ARG LINUX_MINGW64_QT6_DLLS="Core DBus Gui Network PrintSupport \
    Svg SvgWidgets Widgets"
RUN for i in $LINUX_MINGW64_QT6_DLLS; do \
        DLL=`find /build/qt6-mingw-build -name Qt6$i.dll | head -1`; \
        echo $DLL; \
        cp $DLL /build/dist; \
        done
# 9/4. Create sword folder...
WORKDIR /build/dist
RUN unzip /build/bibref/sword-lxx-sblgnt-statresgnt-kjv-fallback.zip
RUN mv .sword sword
# 9/5. Copy addbooks-cache from native build...
RUN cp -a /build/bibref/build/bibref-addbooks-cache /build/dist
# 9/6. Put the .ico file there...
RUN cp /build/bibref/bibref.ico /build/dist
# 9/7. Create sword.conf...
RUN echo "[Install]\n\
DataPath=sword" > /build/dist/sword.conf
# 9/8. Create additional Qt related settings...
RUN for d in styles platforms imageformats; do \
        cp -a /build/qt6-mingw-build/qtbase/plugins/$d /build/dist; \
    done
# 9/9. Create statements folder...
RUN mkdir /build/dist/statements
RUN cp -a /build/bibref/statements/SBLGNT /build/dist/statements
RUN rm -fr /build/dist/statements/SBLGNT/all
RUN cp -a /build/bibref/statements/StatResGNT /build/dist/statements
RUN rm -fr /build/dist/statements/StatResGNT/all
# 9/10. Copy executable...
RUN cp /build/bibref/qt/build/bibref-qt.exe /build/dist
