#!/bin/sh
tailscaled --state=/var/lib/tailscale/tailscaled.state --tun=userspace-networking &
tailscale up --advertise-exit-node --advertise-routes=$VPN_SUBNET --accept-dns=false --hostname=vpn-$VPN_TYPE-$VPN_NAME
