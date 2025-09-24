#!/bin/sh

# Install snowflake-client
torsocks opkg update
torsocks opkg install snowflake-broker snowflake-client snowflake-probetest
# snowflake-proxy & snowflake-server not required

# Install some debug tools
opkg install ss nmap-ssl ncat netcat ethtool tcpdump
