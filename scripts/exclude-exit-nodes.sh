#!/bin/sh

# https://tb-manual.torproject.org/bridges/
# https://openwrt.org/docs/guide-user/services/tor/extras


# Install packages
opkg update
opkg install tor-geoip
 
# Exclude exit nodes
cat << EOF >> /etc/tor/custom
ExcludeExitNodes {??}, {by}, {kz}, {ru}, {ua}
EOF
service tor restart