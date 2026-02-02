#!/usr/bin/bash

set -e

echo -e "\nubuntu-data-workstation - Virtual Environment\n"

if [ $# -ne 1 ]; then
    read -p "Virtual Environment name: " venv_name
else
    venv_name=$1
fi

venv_dir="$HOME/venvs"
venv_fn="$venv_dir"/"$venv_name"
venv_py="$venv_fn/bin/python"

mkdir -p $HOME/venvs

python3 -m venv $venv_fn

$venv_py -m pip install --upgrade --require-virtualenv pip

$venv_py -m pip install --upgrade --require-virtualenv -r resources/requirements.txt

echo "------------------------------------"
echo ""
echo "Finished creating venv: $venv_fn"
echo ""
echo "To run pip_audit: $venv_py -m pip_audit" 
echo ""
read -n 1 -s -p "Press any key to continue..."
echo ""