#!/bin/sh -e
opkg update
opkg install nfs-utils kmod-fs-nfs-v4
mkdir -p /nfs/share
mount -t nfs4 192.168.1.10:/srv/nfs /nfs/share

cat << EOF > /etc/fstab
192.168.1.10:/srv/nfs /nfs/share nfs4 nofail,nolock
