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

echo ""
read -p "Install optional PyPI packages? [y,n]? " opt_pkg
if [ "$opt_pkg" == "y" ] || [ "$opt_pkg" == "Y" ]; then
    $venv_py -m pip install --upgrade --require-virtualenv -r resources/requirements-extra.txt
fi

echo "--------------------------------------------"

$venv_py -m pip_audit

echo "Finished creating venv: $venv_fn"
