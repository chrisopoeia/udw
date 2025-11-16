#!/usr/bin/bash
set -e

# The  dconf-editor  program  provides  a graphical interface for editing 
# settings that are stored by other applications using the  gsettings  
# functions  of  the  glib  library,  or  in  the  dconf  database.  
# The gsettings(1) and dconf(1) utilities provides similar functionality on 
# the commandline.
# https://manpages.ubuntu.com/manpages/noble/man1/dconf-editor.1.html

# The workstation dconf-diff tool can identify updated dconf keys/values after 
# making changes to Ubuntu settings. The search function in dconf Editor can be
# used to find the modified keys. Changes can then be coded in an update script. 

sudo apt -y install dconf-editor