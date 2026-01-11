# This file makes it easier to run bibref (the GUI version) in a Docker virtualization.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build .`.
#    You will get an image ID at the end of the process.
# 3. Allow connection to the host's X11 server by issuing `xhost +local:docker`.
# 4. Run bibref (the GUI version) by entering `sudo docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ID`.
#    where ID stands for the obtained image ID in step 2.
# 5. When finished, stop the web server by using the command `sudo docker kill CID`
#    where CID stands for the obtained container identifier. You can find it by running `sudo docker ps`.
# 6. If no longer used, you can remove the Docker container and image by entering
#    `sudo docker rm CID` and `sudo docker rmi ID`.


# Restrictions (known bugs):
# * In Edit>Preferences, disable Diagram as HTML/SVG (otherwise the program will crash when trying to display a statement graph).
# * Settings cannot be saved and reused in another launch.
# * Icons are missing.


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

# Create the addbooks-cache:
RUN bibref -a

# Build bibref (gui):
WORKDIR ../qt
RUN mkdir build
WORKDIR build
RUN cmake -DWEBENGINE=ON .. && make -j$(nproc) && make install
RUN cp -a ../../build/bibref-addbooks-cache .

# Run bibref (cli) when running the container:
CMD bibref-qt
