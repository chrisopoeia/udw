#!/usr/bin/bash
set -e

# Install git and GitHub CLI.
# Authenticate with GitHub and set username and commit email address.
# This update sets username and email address globally. If you want to set 
# username and email addresses specific to each repository, you will need to 
# do it manually.
# Change your email settings in GitHub before applying this update if you would
# prefer to keep your commit email address private. If you don't, it will be 
# visible on any public repository you commit.

echo "Install git"
sudo apt install git

echo "Install GitHub CLI"
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt -y update \
	&& sudo apt -y install gh -y

echo "Authenticate with GitHub"
gh auth login

echo "Set GitHub username"
read -p "Enter global GitHub username (applies to all repositories on machine): " ghuser
git config --global user.name "$ghuser"

echo "Set GitHub email"
echo "Warning: GitHub email address will be visible when you commit - see GitHub docs if you want to keep your email address private"
read -p "Enter global GitHub email (applies to all repositories on machine): " ghemail
git config --global user.email "$ghemail"