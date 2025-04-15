# 2025-03-10 12:16:25 by RouterOS 7.18.2
# software id = EGTP-G0TI
#
# model = RB750Gr3
# serial number = HG309H58D5Z
/interface bridge
add name=bridge-lan1-dhcp
add name=bridge-lan2-static
/interface ethernet
set [ find default-name=ether1 ] name=ether1-wan
/ip pool
add name=pool-lan ranges=192.168.10.100-192.168.10.150
/ip dhcp-server
add address-pool=pool-lan interface=bridge-lan1-dhcp lease-time=1d name=\
    dhcp-lan-server
/interface bridge port
add bridge=bridge-lan1-dhcp interface=ether4
add bridge=bridge-lan1-dhcp interface=ether5
add bridge=bridge-lan2-static interface=ether2
add bridge=bridge-lan2-static interface=ether3
/ip address
add address=192.168.10.1/24 interface=bridge-lan1-dhcp network=192.168.10.0
add address=10.11.12.1/24 interface=bridge-lan2-static network=10.11.12.0
/ip dhcp-client
add add-default-route=no default-route-tables=main interface=ether1-wan \
    use-peer-dns=no
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=8.8.8.8 gateway=192.168.10.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan
/ip route
add distance=1 dst-address=0.0.0.0/0 gateway=192.168.100.1
/system identity
set name=hex
/system note
set show-at-login=no
