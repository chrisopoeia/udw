#!/usr/bin/bash

set -e

echo -e "\nubuntu-data-workstation - PostgreSQL Setup\n"

if [ $# -ne 1 ]; then
    read -p "Database name: " db_name
else
    db_name=$1
fi

echo -e "Database name: $db_name\n"

pg_owner="$db_name"_owner
echo "Creating PostgreSQL owner: $pg_owner"
sudo -u postgres createuser --no-createdb --pwprompt --no-createrole --no-replication --no-superuser $pg_owner
echo ""
pg_user="$db_name"_user
echo "Creating PostgreSQL user: $pg_user"
sudo -u postgres createuser --no-createdb --pwprompt --no-createrole --no-replication --no-superuser $pg_user
echo ""
read -p "Database locale [default: en_NZ.utf8]: " db_loc
if [ "$db_loc" == "" ]; then
    db_loc="en_NZ.utf8"
fi
echo "create database $db_name owner $pg_owner template 'template0' encoding utf8 lc_collate='$db_loc' lc_ctype='$db_loc';" > /tmp/create_db.sql
echo "REVOKE connect ON DATABASE $db_name FROM PUBLIC;" >> /tmp/create_db.sql
echo "GRANT ALL PRIVILEGES ON DATABASE $db_name TO $pg_user;" >> /tmp/create_db.sql
sudo -i -u postgres psql -f /tmp/create_db.sql
rm /tmp/create_db.sql

echo -e "\nFinished setting up database: $db_name\n"