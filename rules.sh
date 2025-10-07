
#uci add firewall rule
#uci set firewall.@rule[-1].name='Allow-Ping'
#uci set firewall.@rule[-1].src='lan'
#uci set firewall.@rule[-1].target='ACCEPT'
#uci set firewall.@rule[-1].proto='ICMP'
#uci set firewall.@rule[-1].icmp_type='echo-request'
#uci set firewall.@rule[-1].family='ipv4'
#uci commit firewall
#service firewall restart

uci add firewall rule
uci set firewall.@rule[-1].name='Allow Ping6'
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].proto='ICMP'
uci set firewall.@rule[-1].icmp_type='echo-request'
uci set firewall.@rule[-1].family='ipv6'
uci commit firewall
service firewall restart

# Force LAN clients to send DNS queries to dnsmasq (that later will be going to unbound):
#uci add firewall rule
#uci set firewall.@rule[-1].name='Block-Public-DNS'
#uci set firewall.@rule[-1].src='lan'
#uci set firewall.@rule[-1].dest='wan'
#uci set firewall.@rule[-1].dest_port='53 853 5353 9053'
#uci set firewall.@rule[-1].target='REJECT'
#uci commit firewall

# Redirect queries for DNS servers running on non-standard ports.
# Warning: don't use this one if you run an mDNS server
# e.g.: 5353
#uci add firewall redirect
#uci set firewall.@redirect[-1].dest='lan'
#uci set firewall.@redirect[-1].target='DNAT'
#uci set firewall.@redirect[-1].name='Divert-DNS, port 9053'
#uci set firewall.@redirect[-1].src='lan'
#uci set firewall.@redirect[-1].src_dport='9053'
#uci set firewall.@redirect[-1].dest_port='53'
#uci commit firewall
#service firewall reload

# -*- End of file -*-
