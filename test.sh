#! /bin/bash

echo "Enter name for this host again"
read node
sed '1d' /etc/hosts
echo $node >> /etc/hosts
