#!/bin/sh
openvpn --config $VPN_TYPE-$VPN_NAME.ovpn --auth-user-pass $VPN_TYPE-$VPN_NAME.auth --daemon