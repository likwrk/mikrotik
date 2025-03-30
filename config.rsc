# mar/30/2025 13:18:43 by RouterOS 6.49.18
# software id = YM5Y-DLWX
#
# model = RB941-2nD
# serial number = 9D7409771674
/interface bridge
add name=bridge-lan
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface ethernet
set [ find default-name=ether1 ] name=ether1-wan1
set [ find default-name=ether2 ] name=ether2-wan2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge-lan interface=ether3
add bridge=bridge-lan interface=ether4
add bridge=bridge-lan interface=wlan1
/ip address
add address=192.168.100.115/24 interface=ether1-wan1 network=192.168.100.0
add address=192.168.88.1/24 interface=bridge-lan network=192.168.88.0
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan1
/ip route
add distance=1 gateway=192.168.100.1
/system clock
set time-zone-name=Europe/Simferopol
/system identity
set name=GW
