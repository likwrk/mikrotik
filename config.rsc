# apr/15/2025 15:29:46 by RouterOS 6.49.18
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
/interface list
add name=LAN
add name=WAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool-dhcp-lan ranges=192.168.88.101-192.168.88.150
/ip dhcp-server
add address-pool=pool-dhcp-lan disabled=no interface=bridge-lan lease-time=1d \
    name=server-lan
/user group
add name=helpdesk-l3 policy="local,telnet,ssh,reboot,read,write,test,winbox,pa\
    ssword,web,sniff,sensitive,api,romon,tikapp,!ftp,!policy,!dude"
add name=helpdesk-l2 policy="local,telnet,ssh,reboot,read,test,winbox,password\
    ,web,sniff,sensitive,api,romon,tikapp,!ftp,!write,!policy,!dude"
add name=helpdesk-l1 policy="reboot,read,test,web,!local,!telnet,!ssh,!ftp,!wr\
    ite,!policy,!winbox,!password,!sniff,!sensitive,!api,!romon,!dude,!tikapp" \
    skin=helpdesk
/interface bridge port
add bridge=bridge-lan interface=ether3
add bridge=bridge-lan interface=ether4
add bridge=bridge-lan interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add interface=ether1-wan1 list=WAN
add interface=ether2-wan2 list=WAN
add interface=bridge-lan list=LAN
/ip address
add address=10.11.12.115/24 interface=ether1-wan1 network=10.11.12.0
add address=192.168.88.1/24 interface=bridge-lan network=192.168.88.0
/ip dhcp-client
add default-route-distance=2 disabled=no interface=ether2-wan2
/ip dhcp-server lease
add address=192.168.88.101 mac-address=10:D7:C6:F6:F6:21 server=server-lan
add address=192.168.88.102 mac-address=10:D7:C6:F6:F6:22 server=server-lan
/ip dhcp-server network
add address=192.168.88.0/24 dns-server=192.168.88.1 domain=int gateway=\
    192.168.88.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan1
add action=masquerade chain=srcnat out-interface=ether2-wan2
/ip route
add distance=1 gateway=10.11.12.1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Moscow
/system identity
set name=GW
/system ntp client
set enabled=yes server-dns-names=ru.pool.ntp.org
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/tool mac-server ping
set enabled=no
