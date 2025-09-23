#!/bin/sh

# Disable GUA prefix
uci set network.lan.ip6class="local"
uci commit network
service network restart

# Announce IPv6 default route
uci set dhcp.lan.ra_default=1
uci commit dhcp
service network restart

# Using IPv6 by default
NET_ULA="$(uci get network.globals.ula_prefix)"
uci set network.globals.ula_prefix="d${NET_ULA:1}"
uci commit network
service network restart

# Missing GUA prefix
# Suppress warnings
#uci set dhcp.odhcpd.loglevel="3"
#uci commit dhcp
#service odhcpd restart
