# automatic-caddy
Automated Caddy Server installation for Linux 64-bit (for now only) with systemd.

Version downloaded from Caddy official website: https://caddyserver.com/download  
Instructions from official GitHub: https://github.com/mholt/caddy/tree/master/dist/init/linux-systemd

File localization:
- /usr/local/bin/caddy
- /etc/caddy/ (Caddyfile + ssl folder)
- /systemd/system/caddy.service

# How to use
```bash
sudo bash -c "$(curl https://raw.githubusercontent.com/Jonathanyyf/automatic-caddy/master/caddy-installation.sh)"
```
