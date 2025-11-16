#!/usr/bin/bash
set -e

# Change the locale used for PostgreSQL (optional).

read -p "Change PostgreSQL locale (e.g. en_NZ.utf8 for New Zealand UTF8) [y,n]?" reply
if [ "$reply" == "y" ] || [ "$reply" == "Y" ]; then
    read -p "enter new locale (e.g. en_NZ.utf8 for New Zealand UTF8): " input
    sudo locale-gen $input
    sudo update-locale
    locale -a
    sudo service postgresql restart
    echo "$input" > "$HOME/.workstation/.pg-locale"
fi