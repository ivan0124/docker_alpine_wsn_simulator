FROM ubuntu:16.04

#wsn-simulator

#MAINTAINER Advantech

WORKDIR /home/adv
# update and install dev-tools 
RUN apt-get update &&\
    apt-get install -y git-core && \
    apt-get install -y vim && \
    apt-get install -y sudo && \
    useradd -m -k /home/adv adv -p adv -s /bin/bash -G sudo && \
    echo "adv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    git clone --branch wisesnail-lib-v2.0.1 https://github.com/ADVANTECH-Corp/docker-igw-app-x86.git . && \
    ./install_wisesnaillib.sh && \
    rm -rf sample inc lib *.* ./.git && \
    git clone --branch wsn-simulator-v2.0.1 https://github.com/ADVANTECH-Corp/docker-igw-app-x86.git ./wsn-simulator && \
    cp -r ./wsn-simulator/*.* ./wsn-simulator/wsn ./wsn-simulator/wisesim . && \
    rm -rf ./wsn-simulator && \
    apt-get uninstall -y git-core

#USER adv

# Run WSN Simulator  Service
#ENTRYPOINT ["./wisesim"]
