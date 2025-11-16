 #!/usr/bin/bash
set -e

# Machine needs to be restarted after initial setup. Re-run setup after system 
# reboot to complete final steps.

read -p "Reboot now [y,n]?" reply
if [ "$reply" == "y" ] || [ "$reply" == "Y" ]; then
    sudo reboot
    exit 0
else
    echo "Reboot manually when ready then rerun setup to complete final steps."
    exit 0
fi