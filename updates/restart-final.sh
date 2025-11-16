 #!/usr/bin/bash
set -e

# Machine needs a final restart.

read -p "Reboot now [y,n]?" reply
if [ "$reply" == "y" ] || [ "$reply" == "Y" ]; then
    sudo reboot
    exit 0
else
    echo "Reboot manually when ready."
    exit 0
fi