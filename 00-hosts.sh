#!/bin/sh

# -*- Static Hostnames -*-

uci add dhcp host
uci set dhcp.@host[-1].name='void'
uci set dhcp.@host[-1].ip='192.168.1.10'
uci set dhcp.@host[-1].mac= '88:51:fb:15:96:a3'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='void'
uci set dhcp.@host[-1].ip='192.168.1.100'
uci set dhcp.@host[-1].mac='88:51:fb:77:e5:d1'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='rpi3'
uci set dhcp.@host[-1].ip='192.168.1.3'
uci set dhcp.@host[-1].mac='b8:27:eb:c9:aa:ca'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='rpi3'
uci set dhcp.@host[-1].ip='192.168.1.2'
uci set dhcp.@host[-1].mac='c8:a3:62:b9:a5:de'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

uci add dhcp host
uci set dhcp.@host[-1].name='switch'
uci set dhcp.@host[-1].ip='192.168.1.234'
uci set dhcp.@host[-1].mac='28:94:01:66:10:9d'
uci set dhcp.@host[-1].leasetime='12h'
uci set dhcp.@host[-1].dns='1'
uci commit dhcp

# -*- End of file -*-
