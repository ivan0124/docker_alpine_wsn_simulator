FROM alpine:3.4

WORKDIR /home/adv

RUN apk update && \
    apk add --no-cache git bash && \
    git clone --branch wisesnail-lib-v2.0.1 https://github.com/ADVANTECH-Corp/docker-igw-app-x86.git . && \
    ./install_wisesnaillib.sh && \
    /bin/rm -rf sample inc lib *.* ./.git && \
    git clone --branch wsn-simulator-v2.0.1 https://github.com/ADVANTECH-Corp/docker-igw-app-x86.git ./wsn-simulator && \
    /bin/cp -r ./wsn-simulator/*.* ./wsn-simulator/wsn ./wsn-simulator/wisesim . && \
    /bin/rm -rf ./wsn-simulator && \
    apk del git && rm -rf /tmp/* /var/cache/apk/*
  
ENTRYPOINT ["./wisesim"]
