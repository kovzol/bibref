# This file makes it easier to run bibref (the GUI version) in a Docker virtualization.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build .`.
#    You will get an image ID at the end of the process.
# 3. Allow connection to the host's X11 server by issuing `xhost +local:docker`.
# 4. Run bibref (the GUI version) by entering
#    `sudo docker run -it -e DISPLAY=$DISPLAY LANG=$LANG -v /tmp/.X11-unix:/tmp/.X11-unix ID`.
#    where ID stands for the obtained image ID in step 2.
# 5. If you want to restart the program later, use `sudo docker start -ai CID`
#    where CID stands for the obtained container identifier. You can find it by running `sudo docker ps`.
# 6. When finished, stop the web server by using the command `sudo docker kill CID`
# 7. If no longer used, you can remove the Docker container and image by entering
#    `sudo docker rm CID` and `sudo docker rmi ID`.


# Install prerequisites:
FROM debian:trixie
RUN apt-get update && \
    apt-get -y install libsword-common libsword-dev git cmake build-essential \
        libreadline-dev libboost-dev libboost-filesystem-dev bison flex pkgconf unzip \
        qt6-base-dev qt6-tools-dev qt6-tools-dev-tools qt6-l10n-tools \
        linguist-qt6 libgl1-mesa-dev freeglut3-dev libgraphviz-dev qt6-svg-dev qt6-webengine-dev \
        libgl1 mesa-utils x11-apps xdg-utils firefox-esr
RUN git clone https://github.com/kovzol/bibref

# Build bibref (cli):
WORKDIR bibref
RUN mkdir build
WORKDIR build
RUN cmake .. && make -j$(nproc) && make install || true

# Create the addbooks-cache and copy it and the installed Bibles in /tmp:
RUN bibref -a
RUN cp -a bibref-addbooks-cache /tmp
RUN cp -a ~/.sword /tmp

# Create normal user:
RUN useradd -ms /bin/bash user
RUN chown -R user:user /tmp/bibref-addbooks-cache /tmp/.sword

# Build bibref (gui):
WORKDIR ../qt
## Add embedded files (icons, translations) in the executable...
RUN sed -i 's/^[[:space:]]*set[[:space:]]*(BIBREF_QRC_EXTRA[[:space:]]*""[[:space:]]*)/set(BIBREF_QRC_EXTRA "bibref-wasm.qrc")\nqt6_add_translation(QTBASE_QM_FILES ${QTBASE_TRANSLATION_FILES})/' CMakeLists.txt
## Patch main.cpp...
WORKDIR ..
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
WORKDIR qt
RUN mkdir build
WORKDIR build
RUN cmake -DWEBENGINE=ON .. && make -j$(nproc) && make install

# Run bibref (cli) when running the container:
USER user
WORKDIR /home/user
RUN mv /tmp/bibref-addbooks-cache .
RUN mv /tmp/.sword .
CMD QT_QUICK_BACKEND=software QT_OPENGL=software QTWEBENGINE_DISABLE_GPU=1 QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu --disable-software-rasterizer --no-sandbox" bibref-qt
