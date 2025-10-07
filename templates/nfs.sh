#!/bin/sh -e
apk update
apk add nfs-utils kmod-fs-nfs-v4
mkdir -p /srv/nfs
mount -t nfs4 192.168.1.10:/srv/nfs /nfs/share
cat "192.168.1.10:/srv/nfs /srv/nfs nfs4 auto" >> /etc/fstab
# mountpoint added to fstab, but still no automount on boot?
