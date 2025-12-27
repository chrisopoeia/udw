#!/usr/bin/bash

set -e

echo -e "\nubuntu-data-workstation - Backup\n"

# get current timestamp
now=$(date +"%Y%m%d-%H%M")

# make backup & restore directories
sourcedir="$HOME/projects"
backupdir="$HOME/temp/backup-$HOSTNAME-$now"
restoredir="/tmp/restore-$HOSTNAME"
if [ -d $restoredir ]; then
    # delete restore dir & contents
    rm -rf $restoredir
fi
mkdir $backupdir
mkdir $restoredir
excludelist="$HOME/.workstation/exclude.lst"
if [ ! -f $excludelist ]; then
    touch $excludelist
fi

# postgres backup
sudo -i -u postgres pg_dumpall | zip -9 $backupdir/postgres_backup -

# create file lists
ls $sourcedir/* -a --format=single-column --group-directories-first -p -R -1 -U --width=0 > $backupdir/projects-list-name.txt
ls $sourcedir/* -a --group-directories-first -l -p -R --time=mtime -U --width=0 --block-size=K --time-style=long-iso > $backupdir/projects-list-metadata.txt

# compress backup files to zip archive
zip -r -x@$excludelist --symlink -9 -dc $backupdir/projects-backup $sourcedir/*

# create list of backed up files
unzip -l $backupdir/projects-backup  > $backupdir/projects-list-zip.txt

# unzip backup to restore dir
unzip $backupdir/projects-backup.zip -d $restoredir

echo ""
# compare original and restored files
diffresult=$($diff_cmd)
# check if any differences were found
if [ "$diffresult" == "" ]; then
    # no differences - backup ok
    echo "File restore test OK - no differences found"
else
    # differences found - backup failed
    echo "WARNING: Differences found in file restore test, see below"    
    echo ""
    echo $diffresult
    echo ""
    read -n 1 -s -p "Press any key to continue..."
fi
echo ""

# delete restore dir
rm -rf $restoredir

# create backup archive
zip -r -9 -dc $backupdir $backupdir/*

# delete backup dir
rm -rf $backupdir

# start system check
echo "--------------------------------------------"

# check ufw is active
status=$(sudo ufw status)
if [ "$status" == "Status: active" ]; then
    echo "ufw is active"
else
    echo "Error - ufw is not active"
    exit 1
fi

# check apparmor is active
status=$(systemctl is-active apparmor.service)
if [ "$status" == "active" ]; then
    echo "apparmor is active"
else
    echo "Error - apparmor is not active"
    exit 1
fi

df / -BG

echo ""
echo "Backup finished"
echo ""