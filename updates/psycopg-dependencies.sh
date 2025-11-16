#!/usr/bin/bash
set -e

# Install dependencies for psycopg, a Python/PostgreSQL interface. 

sudo apt -y install python3-dev
sudo apt -y install libpq-dev
sudo apt -y install build-essential