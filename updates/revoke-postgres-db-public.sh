#!/usr/bin/bash
set -e

# Revoke public access to the postgres database.

read -p "Revoke public access to database postgres [y,n]?" reply
if [ "$reply" == "y" ] || [ "$reply" == "Y" ]; then
    sudo -u postgres psql -c 'REVOKE connect ON DATABASE postgres FROM PUBLIC;'
fi