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

