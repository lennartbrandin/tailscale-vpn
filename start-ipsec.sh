#!/bin/sh
echo "Starting IPsec via vpnc..."

# vpnc automatically looks for config files, but we specify the exact path to be safe
vpnc ./ipsec-${VPN_NAME}.conf

if [ $? -ne 0 ]; then
    echo "Failed to start vpnc."
    exit 1
fi
