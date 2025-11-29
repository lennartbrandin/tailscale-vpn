This project provides a docker image to running tailscale alongside a vpn client. (Currently wireguard, openconnect, openvpn).

## Usage
Set the files as described below and run `docker compose up -d`.
Run `docker compose logs -f` to see the logs and find the tailscale login link.

Use `example-compose.yaml` as a template, the `base` service is inherited. 
Specifying the docker build args specifies which files are available `COPY ${VPN_TYPE}-${VPN_NAME}.* /vpn`

### Openconnect
If you use a CA cert, also save it as `openconnect-myvpn.pem` in the same directory.
E.g:
```bash
User=myusername
Password=mypassword
Server=myvpn.example.com
CACert=/vpn/openconnect-myvpn.pem # Change only name, /vpn/ is inside the container
Protocol=anyconnect # Keep this
```

### OpenVPN
This i only tested for user-pass auth, create a file `openvpn-myvpn.auth` with the following content:
```
username
password
```
