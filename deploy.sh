#!/bin/bash
DOCKER_API_GW_IMAGE=ivan0124tw/docker_alpine_wsn_simulator:20170110
DOCKER_API_GW_CONTAINER=wsn-simulator
ADVANTECH_NET=advigw_network


#stop container
echo "======================================="
echo "[Step1]: Stop container......"
echo "======================================="
sudo docker stop $DOCKER_API_GW_CONTAINER

#remove container
echo "======================================="
echo "[Step2]: Remove container......"
echo "======================================="
sudo docker rm $DOCKER_API_GW_CONTAINER

#pull images
if [ "$1" == "restart" ] ; then
echo "======================================="
echo "[Step3]: Restart, don't pull container images......"
echo "======================================="
else 
echo "======================================="
echo "[Step3]: Pull container images......"
echo "======================================="
sudo docker pull $DOCKER_API_GW_IMAGE
fi

#create user-defined network `advantech-net`
NET=`sudo docker network ls | grep $ADVANTECH_NET | awk '{ print $2}'`
if [ "$NET" != "$ADVANTECH_NET" ] ; then
echo "======================================="
echo "[Step4]: $ADVANTECH_NET does not exist, create $ADVANTECH_NET network..."
echo "======================================="
sudo docker network create -d bridge --subnet 172.25.0.0/16 i$ADVANTECH_NET
else
echo "======================================="
echo "[Step4]: Found $ADVANTECH_NET network. $ADVANTECH_NET exist."
echo "======================================="
fi

#run container and join to `advantech-net` network
echo "======================================="
echo "[Step5]: Run container images......"
echo "======================================="
#For release
#sudo docker run -itd --name $DOCKER_API_GW_CONTAINER $DOCKER_API_GW_IMAGE

#For develop
sudo docker run -it --name $DOCKER_API_GW_CONTAINER $DOCKER_API_GW_IMAGE /bin/bash


#join to user-defined network advigw_network
echo "======================================="
echo "[Step6]: Join to network advigw_network......"
echo "======================================="
sudo docker network connect $ADVANTECH_NET $DOCKER_API_GW_CONTAINER
