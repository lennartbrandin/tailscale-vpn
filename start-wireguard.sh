#!/bin/sh
cp $VPN_TYPE-$VPN_NAME.conf /etc/wireguard/wg0.conf
wg-quick up wg0
ip rule show | grep -q '51820' || ip rule add from $(ip -4 addr show wg0 | awk '/inet/ {print $2}' | cut -d/ -f1) table 51820
ip route show table 51820 | grep -q 'wg0' || ip route add default dev wg0 table 51820
ip route flush cache
# Export subnet
export VPN_SUBNET=$(ip -4 route | grep 'wg0' | awk '{print $1}')