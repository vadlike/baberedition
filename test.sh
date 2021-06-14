#!/usr/bin/env bash
NEW_HOSTNAME=$1
echo $NEW_HOSTNAME > /proc/sys/kernel/hostname
sed -i 's/127.0.1.1.*/127.0.1.1\t'"$NEW_HOSTNAME"'/g' /etc/hosts
echo $NEW_HOSTNAME > /etc/hostname

