#!/usr/bin/bash
set -e

# Installs VS Code extensions

# Data Wrangler: ms-toolsai.datawrangler
# Jupyter: ms-toolsai.jupyter
# Python: ms-python.python
# Quarto: quarto.quarto (only if Quarto is installed)
# PostgreSQL: ms-ossdata.vscode-pgsql (only if Postgres is installed)

code --install-extension ms-toolsai.datawrangler
code --install-extension ms-toolsai.jupyter
code --install-extension ms-python.python

if [ -f "$HOME/.workstation/.quarto" ]; then
    code --install-extension quarto.quarto
fi

if [ -f "$HOME/.workstation/.updates/.install-postgres" ]; then
    code --install-extension ms-ossdata.vscode-pgsql
fi