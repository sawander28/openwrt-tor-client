uci add firewall rule
uci set firewall.@rule[-1]._name=ping
uci set firewall.@rule[-1].src=wan
uci set firewall.@rule[-1].target=ACCEPT
uci set firewall.@rule[-1].proto=ICMP
uci commit firewall
service firewall restart

uci add firewall rule
uci set firewall.@rule[-1]._name=ping6
uci set firewall.@rule[-1].src=wan6
uci set firewall.@rule[-1].target=ACCEPT
uci set firewall.@rule[-1].proto=ICMP
uci commit firewall
service firewall restart

