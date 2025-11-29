#!/bin/sh
cp $VPN_TYPE-$VPN_NAME.conf /etc/wireguard/wg0.conf
wg-quick up wg0
# Export subnet
export VPN_SUBNET=$(ip -4 route | grep 'wg0' | awk '{print $1}')
