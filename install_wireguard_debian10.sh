apt-get update -y && apt-get upgrade -y

echo "deb http://deb.debian.org/debian buster-backports main" > /etc/apt/sources.list.d/buster-backports.list

apt update

apt install -y wireguard sudo openresolv

dpkg -l | grep wireguard
