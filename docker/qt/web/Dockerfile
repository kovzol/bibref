# This file makes it easier to run bibref (the command line version in web) in a Docker virtualization.
# Warning: You need about about 70 GB of disk space to create the Docker image, and several hours
# of downloading (please use a stable Internet connection) and reasonable compilation time to make everything work.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build -f Dockerfile .`.
#    You will get an image ID at the end of the process.
# 3. Start the web server and allow a network connection to it by issuing `sudo docker run -d -p 8080:80 ID`
#    where ID stands for the obtained image ID in step 2.
#    You will get a container identifier CID as output.
# 4. Open your favorite web browser and open the page **http://localhost:8080/bibref-qt.html**. This starts the program.
#    Note that the current Docker version does not provide a https connection and therefore
#    this link works only with localhost.
# 5. If you want to get the created files for a deployment in FOLDER, use
#    `sudo docker cp CID:/bibref/qt/build-wasm/html-output FOLDER`
#    where CID stands for the obtained container identifier in step 3.
# 6. When finished, stop the web server by using the command `sudo docker kill CID`.
# 7. If no longer used, you can remove the Docker container and image by entering
#    `sudo docker rm CID` and `sudo docker rmi ID`.


# Install prerequisites:
FROM ubuntu:24.04
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get -y install python3 xz-utils subversion git nginx \
        libsword-common libsword-dev build-essential cmake \
        libreadline-dev libboost-dev libboost-filesystem-dev bison flex pkgconf unzip \
        perl qt6-base-dev qt6-tools-dev qt6-tools-dev-tools qt6-l10n-tools \
        linguist-qt6 wget ninja-build libdbus-1-dev
RUN git clone https://github.com/kovzol/bibref
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR emsdk
ENV EMSDK_VER=4.0.7
RUN ./emsdk install $EMSDK_VER
RUN ./emsdk activate $EMSDK_VER
WORKDIR ..

# Build bibref (cli):
WORKDIR bibref
RUN mkdir build
WORKDIR build
RUN cmake .. && make -j$(nproc) && make install || true

# Create the addbooks-cache:
RUN bibref -a
WORKDIR ../..

# Build SWORD:
RUN until svn co https://crosswire.org/svn/sword/trunk/ sword; do [ -d sword ] && (cd sword && svn cleanup && svn update); sleep 5; done
WORKDIR sword
RUN mkdir build
WORKDIR build
RUN . ../../emsdk/emsdk_env.sh && \
    emcmake cmake -DSWORD_BUILD_UTILS=No -DSWORD_BUILD_EXAMPLES=No -DLIBSWORD_LIBRARY_TYPE=Static -DCMAKE_CXX_FLAGS=-sUSE_ZLIB -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ..
RUN yes | make -j$(nproc) sword_static
RUN make install
WORKDIR ../..

# Build Graphviz:
ENV GRAPHVIZ_VER=14.1.1
RUN wget https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/$GRAPHVIZ_VER/graphviz-$GRAPHVIZ_VER.tar.gz
RUN tar xzf graphviz-$GRAPHVIZ_VER.tar.gz
WORKDIR graphviz-$GRAPHVIZ_VER
RUN . ../emsdk/emsdk_env.sh && \
    emconfigure ./configure CFLAGS="-sUSE_ZLIB -pthread" LDFLAGS="-sUSE_ZLIB -pthread" \
        --disable-shared --enable-static --with-qt=no --prefix=$EMSDK/upstream/emscripten/cache/sysroot
RUN make -i -j$(nproc)
RUN make -i install
WORKDIR ..

# Build Qt without Asyncify, with WASM-exceptions and threads:
## Download recent Qt...
ENV QT6_VERSION=6.10.0
RUN git clone git://code.qt.io/qt/qt5.git qt6
WORKDIR qt6
RUN git switch $QT6_VERSION
RUN perl init-repository
## Compile Qt for the Linux host...
WORKDIR ..
RUN mkdir qt6-host-build
WORKDIR qt6-host-build

RUN ../qt6/configure -prefix `pwd`/../qt6-host-install
RUN cmake --build . -j$(nproc)
RUN cmake --install .
## Compile Qt for WebAssembly...
WORKDIR ..
RUN mkdir qt6-wasm-build
WORKDIR qt6-wasm-build
RUN . ../emsdk/emsdk_env.sh && \
    ../qt6/configure -xplatform wasm-emscripten -nomake examples -prefix $PWD/qtbase \
        -opensource -confirm-license -qt-host-path `pwd`/../qt6-host-install -feature-thread -feature-wasm-exceptions
RUN cmake --build . -j$(nproc) -t qtbase -t qtdeclarative -t qtimageformats -t qsvgicon -t qsvg -t qtsvg -t SvgWidgets
WORKDIR ..

# Build bibref (qt-web):
WORKDIR bibref/qt
RUN mkdir build-wasm
WORKDIR build-wasm
RUN . ../../../emsdk/emsdk_env.sh && \
    ../../../qt6-wasm-build/qtbase/bin/qt-cmake -DBIBREF_ADDBOOKS_CACHE_FOLDER=../../../bibref/build/bibref-addbooks-cache ..
RUN yes | make -j$(nproc)
RUN make install

# Set up web server:
EXPOSE 80
RUN cp html-output/* /var/www/html
## Remove comments...
RUN sed -i '/^[[:space:]]*#/d' /etc/nginx/sites-available/default
## Enable correct CORS-settings...
RUN sed -i '/server {/a \
    add_header Cross-Origin-Opener-Policy "same-origin" always;\n\
    add_header Cross-Origin-Embedder-Policy "require-corp" always;' \
    /etc/nginx/sites-available/default

# Allow connection to the web server running in docker:
CMD ["nginx", "-g", "daemon off;"]
