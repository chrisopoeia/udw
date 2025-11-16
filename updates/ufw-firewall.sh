#!/usr/bin/bash
set -e

# ufw is a Linux firewall. This script sets up simple firewall rules (deny 
# incoming, allow outgoing), enables the firewall then checks status.

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
status=$(sudo ufw status)
if [ "$status" != "Status: active" ]; then
    echo "ufw is not active"
    exit 1
fi