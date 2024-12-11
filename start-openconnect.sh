#!/bin/bash
#echo $Password | openconnect --background --user=$User --cafile=$CACert --protocol=$Protocol --passwd-on-stdin $Host
run_openconnect() {
    while true; do
        echo "Connecting to VPN..."
        echo $Password | openconnect --user=$User --cafile=$CACert --protocol=$Protocol --passwd-on-stdin $Host
        echo "Disconnected from VPN. Reconnecting in 5 seconds..."
        sleep 5
    done
}
run_openconnect &

#export VPN_SUBNET=134.28.0.0/16