#!/bin/bash

if [ "$1" = "" ]
then
  echo ":: Usage: $0 Must pass EMAIL_ADDRESS as first argument!"
  exit
fi

echo ':: SETTING USER PW'
sudo passwd $USER

echo ':: SETTING USER SSH KEY'
#ssh-keygen -t rsa -b 4096 -C $1
ssh-keygen -t ed25519 -C $1
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# set the local time
echo ':: SETTING LOCAL TIME'
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Update Aptitude
echo ':: Updating Sources'
sudo apt-get update
sudo apt-get upgrade -y

echo ':: MAKING SURE CURL IS INSTALLED'
sudo apt -y install curl

# add universe repository for fira-code
sudo add-apt-repository universe

# add repository for plata noir theme
sudo add-apt-repository ppa:tista/plata-theme

# setup vscode repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt -y install apt-transport-https
sudo apt update

# Node 16.X
echo ':: Adding Repository for NodeJS'
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

# Install Foundation
echo ':: Installing System Foundation...'
sudo apt-get -y --force-yes install gnupg software-properties-common wget git gcc g++ make build-essential python-setuptools zsh unzip wget software-properties-common

# Atom
# echo ':: Downloading & Installing Deb for Atom'
# wget "https://atom.io/download/deb" -O atom-amd64.deb
# sudo dpkg -i atom-amd64.deb

echo ':: Fixing Broken Installs'
sudo apt-get -y --fix-broken install

# install troublesome ones
echo ":: INSTALLING TROUBLESOME STUFF"
sudo apt-get -y install mongodb nodejs fonts-firacode plata-theme

# install nvm
echo ":: Installing Node Version Manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# oh-my-zsh
echo ":: Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# remove any old packages
sudo apt autoremove

# finaly, print the SSH key so we can add it to github...
cat ~/.ssh/id_ed25519.pub
