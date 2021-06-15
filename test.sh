#! /bin/bash

echo "Enter name for this host"
read node
sed '1d' /etc/hostname
echo $node > /etc/hostname
