#!/bin/sh
tailscaled --state=/var/lib/tailscale/tailscaled.state &
tailscale up --advertise-exit-node --advertise-routes=$VPN_SUBNET --accept-dns=false --hostname=vpn-$VPN_TYPE-$VPN_NAME
iptables -t mangle -F FORWARD
iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1200
