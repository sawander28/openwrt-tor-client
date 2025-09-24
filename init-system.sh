uci set system.ntp.enable_server='1'
uci set system.@system[0].timezone='Europe/Berlin'
uci set system.ntp.enable_server='1'
uci set system.ntp.interface='lan'
uci set luci.main.mediaurlbase=/luci-static/bootstrap-light
