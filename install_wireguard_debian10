apt-get update -y && apt-get upgrade -y

apt update && apt install sudo openresolv -y

echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable.list

printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' > /etc/apt/preferences.d/limit-unstable

apt update

apt install -y wireguard
