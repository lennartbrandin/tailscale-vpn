FROM alpine:latest
ARG VPN_TYPE
ENV VPN_TYPE=$VPN_TYPE
ARG VPN_NAME
ENV VPN_NAME=$VPN_NAME

RUN apk add --no-cache tailscale wireguard-tools openconnect iptables

WORKDIR /vpn
COPY start-${VPN_TYPE}.sh .
COPY start-tailscale.sh .
RUN chmod +x start-*.sh

COPY ${VPN_TYPE}-${VPN_NAME}.* ./

CMD . ./start-${VPN_TYPE}.sh && ./start-tailscale.sh && sleep infinity
