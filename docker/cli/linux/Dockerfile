# This file makes it easier to run bibref (the command line version) in a Docker virtualization.

# How to use this file:
# 1. On Ubuntu Linux, install the package **docker.io**.
# 2. Build the image by entering `sudo docker build .`.
#    You will get an image ID at the end of the process.
# 3. Run bibref (the command line version) interactively by entering `sudo docker run -it ID`
#    where ID stands for the obtained image ID in step 2.
# 4. Eventually, if you want to restart bibref later, find its CID by using `sudo docker ps -a`.
#    Restarting bibref is possible with `sudo docker start -ai CID`.
# 5. If no longer used, you can remove the Docker container and image by entering
#    `sudo docker rm CID` and `sudo docker rmi ID`.


# Install prerequisites:
FROM ubuntu:24.04
RUN apt-get update && \
    apt-get -y install libsword-common libsword-dev git cmake build-essential \
        libreadline-dev libboost-dev libboost-filesystem-dev bison flex pkgconf unzip
ARG GIT_COMMIT=
RUN git clone https://github.com/kovzol/bibref && \
    if [ -n "$GIT_COMMIT" ]; then git checkout $GIT_COMMIT; fi

# Build bibref (cli):
WORKDIR bibref
RUN mkdir build
WORKDIR build
RUN cmake .. && make -j$(nproc) && make install || true

# Create the addbooks-cache:
RUN bibref -a

# Run bibref (cli) when running the container:
CMD bibref -a -c
