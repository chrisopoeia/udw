#!/usr/bin/bash

set -e

echo -e "\nubuntu-data-workstation - Project\n"

default_git_user=$(git config user.name)

read -p "Project name: " project_name
read -p "Repo name [default: $project_name]: " repo_name
if [ "$repo_name" == "" ]; then
    repo_name=$project_name
fi
read -p "GitHub username [default: $default_git_user]: " git_user
if [ "$git_user" == "" ]; then
    git_user=$default_git_user
fi
read -p "Repo branch [default: dev]: " repo_branch
if [ "$repo_branch" == "" ]; then
    repo_branch="dev"
fi
echo ""
echo "! Only use underscores and alphanumeric characters for database and venv names !"
echo ""
read -p "Database name [default: $project_name]: " db_name
if [ "$db_name" == "" ]; then
    db_name=$project_name
fi
read -p "Virtual Environment name [default: $db_name]: " venv_name
if [ "$venv_name" == "" ]; then
    venv_name=$db_name
fi

echo -e "\nParameters"
echo "----------"
echo "Project name:  $project_name"
echo "Repo name:     $repo_name"
echo "GitHub user:   $git_user"
echo "Repo branch:   $repo_branch"
echo "Database name: $db_name"
echo "venv name:     $venv_name"
echo ""
read -p "Continue with the above parameters [y,n]? " confirm
if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
    echo -e "\nParameters confirmed - setting up project\n"
else
    echo -e "\nProject setup cancelled\n"
    exit 1
fi

mkdir $HOME/projects/$project_name
mkdir $HOME/projects/$project_name/storage
mkdir $HOME/projects/$project_name/config

git clone -b "$repo_branch" https://github.com/$git_user/$repo_name.git $HOME/projects/$project_name/$repo_name

bash venv.sh $venv_name

read -p "Modify .gitignore [y,n]? " confirm
    if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
    echo "# custom" > /tmp/.gitignore
    echo ".vscode/" >> /tmp/.gitignore
    echo "quarto/_site/" >> /tmp/.gitignore
    echo "*.ini" >> /tmp/.gitignore
    echo "*.cfg" >> /tmp/.gitignore
    echo "" >> /tmp/.gitignore
    cat $HOME/projects/$project_name/$repo_name/.gitignore >> /tmp/.gitignore
    mv /tmp/.gitignore ~/projects/$project_name/$repo_name/.gitignore
fi

echo "{" > $HOME/workspaces/$project_name.code-workspace
echo "    \"folders\": [" >> $HOME/workspaces/$project_name.code-workspace
echo "        {" >> $HOME/workspaces/$project_name.code-workspace
echo "            \"path\": \"../projects/$project_name/$repo_name\"" >> $HOME/workspaces/$project_name.code-workspace
echo "        }" >> $HOME/workspaces/$project_name.code-workspace
echo "    ]," >> $HOME/workspaces/$project_name.code-workspace
echo "    \"settings\": {}" >> $HOME/workspaces/$project_name.code-workspace
echo "}" >> $HOME/workspaces/$project_name.code-workspace

mkdir $HOME/projects/$project_name/$repo_name/.vscode

code_settings="$HOME/projects/$project_name/$repo_name/.vscode/settings.json"

venv_dir="$HOME/venvs"
venv_fn="$venv_dir"/"$venv_name"
venv_py="$venv_fn/bin/python"

echo "{" >> $code_settings
echo "    \"python.defaultInterpreterPath\": \"$venv_py\"," >> $code_settings
echo "    \"python-envs.pythonProjects\": [" >> $code_settings
echo "        {" >> $code_settings
echo "            \"path\": \"\"," >> $code_settings
echo "            \"envManager\": \"ms-python.python:venv\"," >> $code_settings
echo "            \"packageManager\": \"ms-python.python:pip\"" >> $code_settings
echo "        }" >> $code_settings
echo "    ]," >> $code_settings
echo "    \"editor.rulers\": [79]" >> $code_settings
echo "}" >> $code_settings

bash postgres.sh $db_name

echo -e "Finished setting up project: $project_name \n"