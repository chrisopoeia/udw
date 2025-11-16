#!/usr/bin/bash
set -e

# Sets favorite app icons on the dock (personal preference). 

# VS Code (unreliable; may need to add manually)
# Terminal
# Calculator
# System Monitor
# LibreOffice Calc
# Text Editor
# Brave Browser
# Nautilus

gsettings set org.gnome.shell favorite-apps "['code.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.SystemMonitor.desktop', 'libreoffice-calc.desktop', 'org.gnome.TextEditor.desktop', 'brave-browser.desktop', 'org.gnome.Nautilus.desktop']"