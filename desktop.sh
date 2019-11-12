#!/bin/bash

if [ "$1" = "" ]
then
  echo ":: Usage: $0 Must pass EMAIL_ADDRESS as first argument!"
  exit
fi

echo ':: SETTING USER PW'
sudo passwd $USER

echo ':: SETTING USER SSH KEY'
ssh-keygen -t rsa -b 4096 -C $1
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# set the local time
echo ':: SETTING LOCAL TIME'
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Node 12.X
echo ':: Adding Repository for NodeJS'
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

# Update Aptitude
echo ':: Updating Sources'
sudo apt-get update
sudo apt-get upgrade -y

# Install Foundation
echo ':: Installing System Foundation...'
sudo apt-get -y --force-yes install gnupg software-properties-common wget git gcc g++ make build-essential python-setuptools zsh unzip wget software-properties-common

# Atom
echo ':: Downloading & Installing Deb for Atom'
wget "https://atom.io/download/deb" -O atom-amd64.deb
sudo dpkg -i atom-amd64.deb

echo ':: Fixing Broken Installs'
sudo apt-get -y --fix-broken install

# install troublesome ones
echo ":: INSTALLING TROUBLESOME STUFF"
sudo apt-get -y install mongodb nodejs

# install nvm
echo ":: Installing Node Version Manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

echo ":: Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# finaly, print the SSH key so we can add it to github...
cat ~/.ssh/id_rsa.pub
