#!/usr/bin/bash
set -e

# Configures the Ubuntu GNOME dock

# Personal preference for virtual machines running in VMWare Workstation.

# Positioned at the bottom of the screen
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
# Icon size: 24
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
# Icons centered
gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true
# Auto-hide off
gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
# Use whole screen width (instead of a floating panel)
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
# Don't show mounts
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false

gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false