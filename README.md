This project provides a docker image to running tailscale alongside a vpn client. (Currently wireguard & openconnect).

## Usage
Set the files as described below and run `docker-compose up -d`.
Run `docker-compose logs -f` to see the logs and find the tailscale login link.
### Wireguard
Specify `docker-compose.yaml`, example:
```yaml
services:
  myfavoritevpn0:
    build:
      context: .
      args:
        # ! This makes up the name of the vpn config file e.g wireguard-myv
        - VPN_TYPE=wireguard
        - VPN_NAME=myvpn # This is also the tailscale node name
    volumes:
      - ./myvpn0-data:/var/lib/tailscale
    cap_add:
      - NET_ADMIN
    privileged: true
    restart: unless-stopped
```
Put your config file as `wireguard-myvpn.conf` in the same directory as `compose.yaml`.

### Openconnect
Specify `docker-compose.yaml`, example:
```yaml
services:
  myfavoritevpn1:
    build:
      context: .
      args:
        # ! This makes up the name of the vpn config file e.g openconnect-myvpn.conf
        - VPN_TYPE=openconnect
        - VPN_NAME=myvpn # This is also the tailscale node name
    env_file:
      - openconnect-myvpn.conf
    cap_add:
      - NET_ADMIN
    volumes:
      - ./myvpn1-data:/var/lib/tailscale
    privileged: true
    restart: unless-stopped
```
Put your config file as `openconnect-myvpn.conf` in the same directory as `compose.yaml`.
If you use a CA cert, also save it as `openconnect-myvpn.pem` in the same directory.
E.g:
```bash
User=myusername
Password=mypassword
Server=myvpn.example.com
CACert=/vpn/mycert.pem # Change only name, /vpn/ is inside the container
Protocol=anyconnect # Keep this
```