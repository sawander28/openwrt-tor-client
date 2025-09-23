#!/bin/sh

# dnsleak
# https://dnsleaktest.com/
# https://dnscheck.tools/
# dnssec
# http://dnssec-or-not.com/
# https://wander.science/projects/dns/dnssec-resolver-test/

# Restart services
service log restart; service unbound restart
 
# Log and status
logread -e unbound; netstat -l -n -p | grep -e unbound
 
# Runtime configuration
pgrep -f -a unbound
head -v -n -0 /etc/resolv.* /tmp/resolv.* /tmp/resolv.*/*
 
# Persistent configuration
uci show unbound
