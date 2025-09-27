if [ -f /etc/init.d/tor ]; then
    uci add network interface
    uci rename network.@interface[-1]=tor
    uci set network.@interface[-1].proto=static
    uci set network.@interface[-1].ipaddr=192.168.2.1
    uci set network.@interface[-1].netmask=255.255.255.0
    uci commit network
    
    uci add dhcp dhcp
    uci rename dhcp.@dhcp[-1]=tor
    uci set dhcp.@dhcp[-1].interface=tor
    uci set dhcp.@dhcp[-1].start=100
    uci set dhcp.@dhcp[-1].limit=150
    uci set dhcp.@dhcp[-1].leasetime=12h
    uci commit dhcp
    
    uci add wireless wifi-iface
    uci set wireless.@wifi-iface[-1]=wifi-iface
    uci set wireless.@wifi-iface[-1].device=radio0
    uci set wireless.@wifi-iface[-1].network=tor
    uci set wireless.@wifi-iface[-1].mode=ap
    uci set wireless.@wifi-iface[-1].ssid='OpenWrt-Tor'
    uci set wireless.@wifi-iface[-1].encryption=psk2
    uci set wireless.@wifi-iface[-1].key=changeme
    uci set wireless.@wifi-iface[-1].isolate=1
    uci set wireless.@wifi-iface[-1].macaddr='00:88:88:88:00:2A'
    uci set wireless.@wifi-iface[-1].disabled=0
    uci commit wireless

    uci add firewall zone
    uci set firewall.@zone[-1].name=tor
    uci set firewall.@zone[-1].input=REJECT
    uci set firewall.@zone[-1].output=ACCEPT
    uci set firewall.@zone[-1].forward=REJECT
    uci set firewall.@zone[-1].conntrack=1
    uci set firewall.@zone[-1].network=tor
    
    uci add firewall rule
    uci set firewall.@rule[-1].target=ACCEPT
    uci set firewall.@rule[-1].src=tor
    uci set firewall.@rule[-1].proto=udp
    uci set firewall.@rule[-1].dest_port=67
    uci set firewall.@rule[-1].name='Allow Tor DHCP Requests'
    
    uci add firewall rule
    uci set firewall.@rule[-1].target=ACCEPT
    uci set firewall.@rule[-1].src=tor
    uci set firewall.@rule[-1].proto=tcp
    uci set firewall.@rule[-1].dest_port=9040
    uci set firewall.@rule[-1].name='Allow Tor Transparent Proxy'

    uci add firewall rule
    uci set firewall.@rule[-1].target=ACCEPT
    uci set firewall.@rule[-1].src=tor
    uci set firewall.@rule[-1].proto=tcp
    uci set firewall.@rule[-1].dest_port=9053
    uci set firewall.@rule[-1].name='Allow Tor DNS Proxy'

    uci add firewall redirect
    uci set firewall.@redirect[-1].name='Redirect Tor Traffic'
    uci set firewall.@redirect[-1].src=tor
    uci set firewall.@redirect[-1].src_dip='!192.168.1.0/24'
    uci set firewall.@redirect[-1].dest_port=9040
    uci set firewall.@redirect[-1].proto=tcp
    uci set firewall.@redirect[-1].target=DNAT
    uci set firewall.@redirect[-1].reflection=0
    
    uci add firewall redirect
    uci set firewall.@redirect[-1].name='Redirect Tor DNS'
    uci set firewall.@redirect[-1].src=tor
    uci set firewall.@redirect[-1].src_dport=53
    uci set firewall.@redirect[-1].dest_port=9053
    uci set firewall.@redirect[-1].proto=udp
    uci set firewall.@redirect[-1].target=DNAT
    uci set firewall.@redirect[-1].reflection=0

    uci add firewall rule
    uci set firewall.@rule[-1]=rule
    uci set firewall.@rule[-1].name='Deny Tor LAN Access'
    uci set firewall.@rule[-1].src=tor
    uci set firewall.@rule[-1].dest=lan
    uci set firewall.@rule[-1].proto=all
    uci set firewall.@rule[-1].target=DROP

    uci commit firewall

    echo "VirtualAddrNetwork 10.192.0.0/10" >> /etc/tor/torrc
    echo "AutomapHostsOnResolve 1" >> /etc/tor/torrc
    echo "TransPort 9040" >> /etc/tor/torrc
    echo "TransListenAddress 192.168.1.1" >> /etc/tor/torrc
    echo "DNSPort 9053" >> /etc/tor/torrc
    echo "DNSListenAddress 192.168.1.1" >> /etc/tor/torrc
    
    /etc/init.d/tor enable
fi
