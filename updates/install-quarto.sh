#!/usr/bin/bash
set -e

# Install the Quarto publishing system. 

version="1.8.24"

wget -P /tmp/ https://github.com/quarto-dev/quarto-cli/releases/download/v$version/quarto-$version-linux-amd64.deb
sudo dpkg -i /tmp/quarto-$version-linux-amd64.deb
rm /tmp/quarto-$version-linux-amd64.deb

now=$(date +"%Y-%m-%d %H:%M:%S.%3N")
touch "$HOME/.workstation/.quarto"
echo "v$version installed $now" >> "$HOME/.workstation/.quarto"