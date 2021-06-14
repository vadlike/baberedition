#!/bin/bash
# Copyright 2014 Cumulus Networks, Inc. All rights reserved.
# Author: Stanley Karunditu stanleyk@cumulusnetworks.com

# Change the hostname without reboot.
# * Script is interactive
# Applies only to debian based OS

# Example:
# ./change_hostname.sh mynewswitch
#
die () {
  echo >&2 "$@"
  exit 1
}

[ "$#" -eq 1 ] || die "new hostname is required"
# Help text
if [ "$1" == '-h' ]; then
  echo "Usage: `basename $0` [newhostname]
Change hostname without a reboot"
  exit 0
fi

OLD_HOSTNAME=`/bin/hostname`
NEW_HOSTNAME=$1

# Yes/no, yes/no, yes/no.. :)
read -p "Change Hostname from '${OLD_HOSTNAME}' to '${NEW_HOSTNAME}'
ARE YOU SURE? [y/N] " -n 2 -r

if [[ $REPLY =~ ^[yY]$ ]]
then
  # change runtime hostname
  hostname $1


  cp /etc/hostname /etc/hostname.bak
  echo $NEW_HOSTNAME > /etc/hostname

  # change hostname in host table. Looks like a Debian thing.
  # http://www.debian.org/doc/manuals/debian-reference/ch05.en.html#_the_hostname_resolution
  cp /etc/hosts /etc/hosts.bak
  sed -i "/127\.0\.1\.1/ s/${OLD_HOSTNAME}/${NEW_HOSTNAME}/" /etc/hosts

  echo \
"Hostname changed to '${NEW_HOSTNAME}'
If the hostname is present in the bash prompt.
Log out and log back in"

fi
