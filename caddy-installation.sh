#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[93m"

# Check sudo
if [[ $(id -u) != 0 ]]; then 
		echo -e "${R}Please use the script as root${N}"
		exit 1
fi

# Download caddy
wget -O /var/tmp/caddy.tar.gz "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off"

# tar decompress 'caddy' only to '/usr/local/bin/'
tar xvf /var/tmp/caddy.tar.gz caddy -C /usr/local/bin/

# Set permission to the file
chown root:root /usr/local/bin/caddy
chmod 755 /usr/local/bin/caddy

# Bind to 80/443 with non-root (www-data)
setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy

# Add www-data user/group
if [[ $(id -u www-data) ]]; then 
    echo User www-data exist, continuing installation; 
  else 
    echo Creating user www-data
    groupadd -g 33 www-data
    useradd \
      -g www-data --no-user-group \
      --home-dir /var/www --no-create-home \
      --shell /usr/sbin/nologin \
      --system --uid 33 www-data;
fi

# Create needed path + permissions
mkdir /etc/caddy
chown -R root:root /etc/caddy
mkdir /etc/ssl/caddy
chown -R root:www-data /etc/caddy/ssl
chmod 0770 /etc/caddy/ssl

# Create 'Caddyfile'
touch /etc/caddy/Caddyfile
chown root:root /etc/caddy/Caddyfile
chmod 644 /etc/caddy/Caddyfile

# Home directory for web server
#mkdir /var/www
#chown www-data:www-data /var/www
#chmod 555 /var/www

# Install Caddy as a systemd service
wget -O /etc/systemd/system/caddy.service "https://raw.githubusercontent.com/lalalolo49/automatic-caddy/master/caddy.service"
chown root:root /etc/systemd/system/caddy.service
chmod 644 /etc/systemd/system/caddy.service
systemctl daemon-reload
systemctl start caddy.service
