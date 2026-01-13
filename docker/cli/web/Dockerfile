# This file makes it easier to run bibref (the command line version in web) in a Docker virtualization.

# How to use this file:
# 1. On an Ubuntu Linux, install the package **docker.io**. This machine will be called your container's host.
# 2. Build the image by entering `sudo docker build -f Dockerfile .`.
#    You will get an image ID at the end of the process.
# 3. Start the web server and allow a network connection to it by issuing `sudo docker run -d -p 8080:80 ID`
#    where ID stands for the obtained image ID in step 2.
#    You will get a container identifier CID as output.
# 4. Open your favorite web browser and open the page **http://localhost:8080/index-jt-dt.html**. This starts the program.
#    In case you want to start the program from a different machine than the container's host,
#    use the IP address of the container's host instead of "localhost" in the URL.
# 5. If you want to get the created files for a deployment in FOLDER, use
#    `sudo docker cp CID:/bibref/build-wasm/html-output FOLDER`
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
        libreadline-dev libboost-dev libboost-filesystem-dev bison flex pkgconf unzip
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR emsdk
ENV EMSDK_VER=4.0.3
RUN ./emsdk install $EMSDK_VER
RUN ./emsdk activate $EMSDK_VER
WORKDIR ..

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

# Build bibref (cli):
RUN git clone https://github.com/kovzol/bibref
WORKDIR bibref
RUN mkdir build
WORKDIR build
RUN cmake .. && make -j$(nproc) && make install || true

# Create the addbooks-cache:
RUN bibref -a

# Build bibref (cli-web):
WORKDIR ..
RUN mkdir build-wasm
WORKDIR build-wasm
RUN . ../../emsdk/emsdk_env.sh && \
    emcmake cmake .. -DBIBREF_ADDBOOKS_CACHE_FOLDER=../build/bibref-addbooks-cache
RUN yes | make -j$(nproc)
RUN make install

# Set up web server:
EXPOSE 80
RUN cp html-output/* /var/www/html

# Allow connection to the web server running in docker:
CMD ["nginx", "-g", "daemon off;"]
