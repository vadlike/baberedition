#!/bin/bash

apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

apt-get update

apt-get install docker-ce

curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

curl -fsSL https://get.docker.com/ -o get-docker.sh
sh get-docker.sh

# portainer
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/host/data:/data portainer/portainer-ce

docker -v

docker-compose --version
