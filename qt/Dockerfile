# This file makes it easier to run bibref (the GUI version) in a Docker virtualization.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build .`.
#    You will get an image ID at the end of the process.
# 3. Allow connection to the host's X11 server by issuing `xhost +local:docker`.
# 4. Run bibref (the GUI version) by entering `sudo docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ID`.
#    where ID stands for the obtained image ID in step 2.

# Restrictions (known bugs):
# * In Edit>Preferences, disable Diagram as HTML/SVG (otherwise the program will crash).
# * All options that need starting a web browser have currently no effect.


# Install prerequisites:
FROM ubuntu:24.04
RUN apt-get update && \
    apt-get -y install libsword-common libsword-dev git cmake build-essential \
        libreadline-dev libboost-dev libboost-filesystem-dev bison flex pkgconf unzip \
        qt6-base-dev qt6-tools-dev qt6-tools-dev-tools qt6-l10n-tools \
        linguist-qt6 libgl1-mesa-dev freeglut3-dev libgraphviz-dev qt6-svg-dev qt6-webengine-dev \
        libgl1 mesa-utils x11-apps

RUN git clone https://github.com/kovzol/bibref

# Build bibref (cli):
WORKDIR bibref
RUN mkdir build
WORKDIR build
RUN cmake .. && make && make install || true

# Create the addbooks-cache:
RUN bibref -a

# Build bibref (gui):
WORKDIR ../qt
RUN mkdir build
WORKDIR build
RUN cmake -DWEBENGINE=ON .. && make && make install
RUN cp -a ../../build/bibref-addbooks-cache .

# Run bibref (cli) when running the container:
CMD bibref-qt
