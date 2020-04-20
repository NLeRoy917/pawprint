#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'

clear
cat greeting.txt

# create main directory
echo " "
echo "========================"
printf "Enter project name: "
read proj_name

echo "Running project set-up for $proj_name..."

# check dependencies
command -v npx >/dev/null 2>&1 || { echo >&2 "pawprint requires npx but it's not installed.  Aborting."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo >&2 "pawprint requires python 3 (python3) but it's not installed. Aborting."; exit 1; }

# remove .git directory
y | rm -rf .git/

# install guincorn dependency and create requirements.txt
python3 -m pip install gunicorn
python3 -m pip install flask
python3 -m pip install flask_cors

# create requirements.txt
python3 -m pip freeze > requirements.txt

# make directories
mkdir lib
mkdir static
mkdir templates

# create base flask application
cp files/python/flask_base.py ./
mv flask_base.py app.py

# create heroku procfile for flask app
cp files/heroku/Procfile_flask
mv Procfile_flask Procfile

# create web directory
mkdir frontend
cd frontend/

# run create react app
npx create-react-app $proj_name

# move into newly created directory
cd $proj_name

# create heroku profile
cp ../../files/heroku/Procfile_react ./
mv Procfile_react Procfile

# move back to base directory
cd ../../

# remove tamplate files
rm -r files/
rm greeting.txt
rm setup.sh

echo -e "You are now free to run ${CYAN}git init ${NC}to initialize a new git repository"
echo "Thank you for using pawprint!"


