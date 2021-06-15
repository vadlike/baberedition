#! /bin/bash

echo "Enter name for this host again"
read node
sed '1d' /etc/hosts
echo '127.0.1.1       $node' >> /etc/hosts
