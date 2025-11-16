#!/usr/bin/bash
set -e

# Requires update: create-home-dirs

# Hide unnecessary directories and files from workstation home directory. 
# Change XDG default file locations. 

# change default XDG dirs (use ~/temp)
mv $HOME/.config/user-dirs.dirs $HOME/.config/user-dirs.dirs.old
cp resources/user-dirs.dirs $HOME/.config/user-dirs.dirs

# hide unused files and directories
echo Desktop > $HOME/.hidden
echo Documents >> $HOME/.hidden
echo Downloads >> $HOME/.hidden
echo Music >> $HOME/.hidden
echo Pictures >> $HOME/.hidden
echo Public >> $HOME/.hidden
echo snap >> $HOME/.hidden
echo Templates >> $HOME/.hidden
echo Videos >> $HOME/.hidden

# hide above files when using ls
aliasls=$(cat resources/bash_aliases)
echo "$aliasls" >> $HOME/.bash_aliases