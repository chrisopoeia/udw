#!/usr/bin/bash

set -e

echo "Please close any open programs then press any key to continue..."
read -n 1 -s

echo "Creating dirs for setup history"
mkdir -p "$HOME/.workstation"
mkdir -p "$HOME/.workstation/.updates"
if [ ! -f "$HOME/.workstation/.setup.log" ]; then
    touch "$HOME/.workstation/.setup.log"
fi

echo "Getting setup type (minimal, full or prompt)"
if [ -f "$HOME/.workstation/.setup_type" ]; then
    setup_type=$(cat "$HOME/.workstation/.setup_type")
else
    echo
    read -p "Do you want setup to include minimal updates [m], all updates [a], or prompt each time [p]? " setup_type
    if [ "$setup_type" == "m" ] || [ "$setup_type" == "m" ]; then
        setup_type="minimal"
    elif [ "$setup_type" == "a" ] || [ "$setup_type" == "A" ]; then
        setup_type="all"
    elif [ "$setup_type" == "p" ] || [ "$setup_type" == "P" ]; then
        setup_type="prompt"
    else
        echo "Invalid setup type: $setup_type"
        exit 1
    fi
fi
echo "Setup type: $setup_type"
echo $setup_type > "$HOME/.workstation/.setup_type"

# function: runs update scripts in ./updates
function apply_update() {
    if [ -f "$HOME/.workstation/.updates/.$1" ] || [ -f "$HOME/.workstation/.updates/.$1[no]" ]; then
        echo "Skipping update (already applied): $1"
    else
        if [ "$setup_type" == "prompt" ]; then
            echo -e "\n----------------------------"
            cat "updates/$1.sh"
            echo -e "\n----------------------------"
            read -p "Apply update $1? " apply
            if [ "$apply" == "y" ] || [ "$setup_type" == "Y" ]; then
                apply=1
            else
                apply=0
            fi
        else
            apply=1
        fi
        now=$(date +"%Y-%m-%d %H:%M:%S.%3N")
        if [ $apply == 1 ]; then
            echo "Applying update: $1"
            ./"updates/$1.sh"
            echo "$now" > "$HOME/.workstation/.updates/.$1"
            echo "$now $1" >> "$HOME/.workstation/.setup.log"
            echo "Finished applying update: $1"
        else
            echo "$now" > "$HOME/.workstation/.updates/.$1[no]"
            echo "Skipped update: $1"
        fi
    fi
}

# minimal initial updates
apply_update "pre-setup-apt-upgrade"
apply_update "ufw-firewall"
apply_update "prevent-power-saving"
apply_update "brave-browser"
apply_update "uninstall-firefox"

# additional (non-minimal) updates
if [ "$setup_type" == "all" ] || [ "$setup_type" == "prompt" ]; then
    apply_update "create-home-dirs"
    if [ -f "$HOME/.workstation/.updates/.create-home-dirs" ]; then
        apply_update "declutter-home-dir"
    fi
    apply_update "install-python-venv"
    apply_update "install-postgres"
    if [ -f "$HOME/.workstation/.updates/.install-postgres" ]; then
        apply_update "change-postgres-locale"
        apply_update "revoke-postgres-db-public"
        apply_update "psycopg-dependencies"
        apply_update "pgadmin"
    fi
    apply_update "install-quarto"
    apply_update "install-vs-code"
    if [ -f "$HOME/.workstation/.updates/.install-vs-code" ]; then
        apply_update "install-vs-code-extensions"
    fi
    apply_update "exiftool"
    apply_update "traceroute"
    apply_update "tree"
    apply_update "install-libre-office-calc"
    apply_update "install-dconf-editor"
    apply_update "install-nginx"
    apply_update "github-authentication"
fi

# need a reboot during initial install
if [ ! -f "$HOME/.workstation/.updates/.restart" ]; then
echo -e "\nMachine needs to be restarted after initial setup. Re-run setup after system reboot to complete final steps.\n"
    apply_update "restart"
    echo "Rerun setup after reboot to complete final steps."
    exit 0
fi

# minimal final updates
apply_update "post-setup-apt-upgrade"
apply_update "dark-style"
apply_update "dock-config"
apply_update "set-favorite-apps"

# need a reboot after initial install
if [ ! -f "$HOME/.workstation/.updates/.restart-final" ]; then
echo -e "\nMachine needs a final restart.\n"
    apply_update "restart-final"
    echo "Machine is ready for use after final restart."
    exit 0
fi

echo "Setup finished"
exit 0