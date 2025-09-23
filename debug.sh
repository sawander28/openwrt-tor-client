#!/bin/sh

# Verify tor connection status
https://check.torproject.org/check/ip

# Check your IP and DNS provider.
https://ipleak.net/
https://www.dnsleaktest.com/


# Restart services
service log restart; service firewall restart; service tor restart
 
# Log and status
logread -e Tor; netstat -l -n -p | grep -e tor
 
# Runtime configuration
pgrep -f -a tor
nft list ruleset
 
# Persistent configuration
uci show firewall; uci show tor; grep -v -r -e "^#" -e "^$" /etc/tor
