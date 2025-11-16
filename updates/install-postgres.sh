#!/usr/bin/bash
set -e

# Install PostgreSQL and set a password for user: postgres.

sudo apt -y install postgresql
sudo -u postgres psql -c "\password"    