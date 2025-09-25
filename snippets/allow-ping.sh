uci add firewall rule
uci set firewall.@rule[-1]._name='Allow-Ping'
uci set firewall.@rule[-1].src='wan'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].proto='ICMP'
uci set firewall.@rule[-1].icmp_type='echo-request'
uci set firewall.@rule[-1].family='ipv4'
uci commit firewall
service firewall restart

uci add firewall rule
uci set firewall.@rule[-1]._name='Allow-Ping6'
uci set firewall.@rule[-1].src='wan'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].proto='ICMP'
uci set firewall.@rule[-1].icmp_type='echo-request'
uci set firewall.@rule[-1].family='ipv6'
uci commit firewall
service firewall restart

