FROM alpine:3.4

WORKDIR /home/adv

RUN apk update && \
    apk add --no-cache git bash && \
    git clone --branch wisesnail-lib-v2.0.1 https://github.com/ADVANTECH-Corp/docker-igw-app-x86.git . && \
    apk del git && rm -rf /tmp/* /var/cache/apk/*
  
#ENTRYPOINT ["./wisesim"]
