FROM alpine:latest AS base
ARG VPN_TYPE
ENV VPN_TYPE=$VPN_TYPE
ARG VPN_NAME
ENV VPN_NAME=$VPN_NAME

RUN apk add --no-cache tailscale iptables ip6tables curl

FROM base
RUN if [[ "$VPN_TYPE" == "openconnect" ]]; then \
        apk add --no-cache openconnect; \
    elif [[ "$VPN_TYPE" == "wireguard" ]]; then \
        apk add --no-cache wireguard-tools; \
    elif [[ "$VPN_TYPE" == "openvpn" ]]; then \
        apk add --no-cache openvpn; \
    elif [[ "$VPN_TYPE" == "ipsec" ]]; then \
        apk add --no-cache vpnc; \
    else \
        echo "Unsupported VPN type: $VPN_TYPE"; exit 1; \
    fi

WORKDIR /vpn
COPY start-${VPN_TYPE}.sh .
COPY start-tailscale.sh .
RUN chmod +x start-*.sh

COPY ${VPN_TYPE}-${VPN_NAME}.* ./

CMD . ./start-${VPN_TYPE}.sh && ./start-tailscale.sh && sleep infinity
