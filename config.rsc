# apr/23/2025 17:01:28 by RouterOS 6.49.18
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
/interface l2tp-server
add name=l2tp-in-filial1 user=filial1
/interface list
add name=LAN
add name=WAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool-dhcp-lan ranges=192.168.88.101-192.168.88.150
add name=pool-vpn ranges=172.16.1.101-172.16.1.150
/ip dhcp-server
add address-pool=pool-dhcp-lan disabled=no interface=bridge-lan lease-time=1d \
    name=server-lan
/ppp profile
add change-tcp-mss=yes local-address=172.16.100.100 name=\
    profile-client-to-site remote-address=pool-vpn
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
/interface l2tp-server server
set authentication=mschap2 enabled=yes ipsec-secret=ipsec use-ipsec=required
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
/ip firewall address-list
add address=fb.com list=social-networks
add address=ok.ru list=social-networks
add address=facebook.com list=social-networks
add address=vk.com list=social-networks
add address=192.168.88.101 list=staff-no-social
add address=192.168.88.102 list=staff-no-social
/ip firewall filter
add action=accept chain=input connection-state=established,related
add action=drop chain=input connection-state=invalid
add action=accept chain=input protocol=icmp
add action=accept chain=input dst-port=22,8291 protocol=tcp src-address-list=\
    wan-white-list
add action=accept chain=input dst-port=1701 protocol=udp
add action=accept chain=input dst-port=500,4500 protocol=udp
add action=accept chain=input protocol=ipsec-esp
add action=drop chain=input in-interface-list=!LAN
add action=accept chain=forward connection-state=established,related
add action=drop chain=forward connection-state=invalid
add action=drop chain=forward connection-nat-state=!dstnat in-interface-list=\
    WAN
add action=reject chain=forward dst-address-list=social-networks protocol=tcp \
    reject-with=tcp-reset src-address-list=staff-no-social time=\
    9h-18h,mon,tue,wed,thu,fri
/ip firewall nat
add action=src-nat chain=srcnat comment=WAN1 out-interface=ether1-wan1 \
    to-addresses=10.11.12.115
add action=src-nat chain=srcnat comment=WAN2 out-interface=ether2-wan2 \
    to-addresses=192.168.10.149
add action=dst-nat chain=dstnat comment="Port-forwarding server 1" dst-port=\
    443 in-interface-list=WAN protocol=tcp to-addresses=192.168.88.11 \
    to-ports=443
add action=dst-nat chain=dstnat comment="Port-forwarding server 2" dst-port=\
    444 in-interface-list=WAN protocol=tcp to-addresses=192.168.88.12 \
    to-ports=443
add action=redirect chain=dstnat comment="DNS redirect" dst-port=53 protocol=\
    udp
/ip route
add check-gateway=ping distance=1 gateway=10.11.12.1
add distance=1 dst-address=192.168.200.0/24 gateway=172.16.100.2
/ip service
set telnet disabled=yes
set ftp disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ppp secret
add name=sotrudnik1 password=password profile=profile-client-to-site service=\
    l2tp
add local-address=172.16.100.1 name=filial1 password=password remote-address=\
    172.16.100.2 service=l2tp
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
