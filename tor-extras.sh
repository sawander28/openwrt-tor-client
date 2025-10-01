# Enable ntp server
uci set system.ntp.enable_server='1'
uci set system.ntp.interface='lan'
uci set system.@system[0].timezone='Europe/Berlin'
uci commit system

uci set luci.main.mediaurlbase=/luci-static/bootstrap-light
uci commit luci

uci add firewall rule
uci set firewall.@rule[-1].name='Allow-Ping'
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].proto='ICMP'
uci set firewall.@rule[-1].icmp_type='echo-request'
uci set firewall.@rule[-1].family='ipv4'
uci commit firewall
service firewall restart

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

# set loopback device as dns for IPv4 & IPv6
uci set network.lan.peerdns='0'
uci set network.lan.dns='127.0.0.1'
uci set network.lan.dns='::1'
uci set network.lan.dns_metric='10'
uci commit network

uci set network.wan.peerdns='0'
uci set network.wan.dns='127.0.0.1'
uci set network.wan.dns_metric='20'
uci commit network

uci set network.wan6.peerdns='0'
uci set network.wan6.dns='::1'
uci set network.wan6.dns_metric='30'
uci commit network

uci add dhcp host
uci set dhcp.@host[-1].name='z620'
uci set dhcp.@host[-1].ip='192.168.1.10'
uci set dhcp.@host[-1].mac='88:51:fb:3f:2c:e4'
uci set dhcp.@host[-1].duuid='000100013021bb048851fb3f2ce4'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='z620'
uci set dhcp.@host[-1].ip='192.168.1.20'
uci set dhcp.@host[-1].mac='88:51:fb:3f:2c:e5'
uci set dhcp.@host[-1].duuid='000100013021bb048851fb3f2ce4'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='rpi3'
uci set dhcp.@host[-1].ip='192.168.1.2'
uci set dhcp.@host[-1].mac='C8:A3:62:B9:A5:DE'
uci set dhcp.@host[-1].duuid='00010001c792bc86b827ebc9aaca'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp
