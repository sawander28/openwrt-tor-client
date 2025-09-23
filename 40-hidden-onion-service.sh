#!/bin/sh

# hidden Onion services
# https://openwrt.org/docs/guide-user/services/tor/hs
#
# required:
# Client-Authorization
# Selective routing

# Install packages
opkg update
opkg install tor-hs

# Configure Tor onion service
uci -q delete tor-hs.ssh
uci set tor-hs.ssh="hidden-service"
uci set tor-hs.ssh.Name="ssh"
uci set tor-hs.ssh.Enabled="1"
uci set tor-hs.ssh.IPv4="127.0.0.1"
uci add_list tor-hs.ssh.PublicLocalPort="22;22"
uci commit tor-hs
service tor-hs restart

# Fetch onion service hostname
TOR_HOST="$(cat /etc/tor/hidden_service/ssh/hostname)"

# Access onion service from Tor client
opkg update
opkg install torsocks

# Access onion service
torsocks ssh $TOR_HOST
