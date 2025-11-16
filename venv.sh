#!/usr/bin/bash
set -e

read -p "Virtual Environment name: " venv_name

venv_dir="$HOME/venvs"
venv_fn="$venv_dir"/"$venv_name"
venv_py="$venv_fn/bin/python"

mkdir -p $HOME/venvs

python3 -m venv $venv_fn

$venv_py -m pip install --upgrade --require-virtualenv pip

$venv_py -m pip install --upgrade --require-virtualenv -r resources/requirements.txt

echo "--------------------------------------------"

$venv_py -m pip_audit

echo "Finished creating venv: $venv_fn"