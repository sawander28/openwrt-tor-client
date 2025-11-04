#!/bin/sh

opkg update
opkg install unbound-daemon unbound-control-setup
opkg install unbound-anchor unbound-host unbound-checkconf adblock-fast
opkg install luci-app-unbound luci-app-adblock-fast

# Set Cloudflare as default upstream dns and Google as fallback
uci set unbound.fwd_google.enabled="0"
uci set unbound.fwd_google.fallback="1"
uci set unbound.fwd_cloudflare.enabled="1"
uci set unbound.fwd_cloudflare.fallback="0"
uci commit unbound
service unbound restart

# Enforce DNSSEC validation
uci set unbound.@unbound[0].validator="1"
uci commit unbound
service unbound restart











# Restart services
service log restart; service unbound restart
 
# Log and status
logread -e unbound; netstat -l -n -p | grep -e unbound
 
# Runtime configuration
pgrep -f -a unbound
head -v -n -0 /etc/resolv.* /tmp/resolv.* /tmp/resolv.*/*
 
# Persistent configuration
uci show unbound
