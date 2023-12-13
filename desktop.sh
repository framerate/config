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

# Setup repo for glow
echo "Setting up repository for GLOW"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# add universe repository for fira-code
echo "Adding universe repository"
sudo add-apt-repository --yes universe

# update everything
sudo apt-get update

# Install Foundation
echo ':: Installing System Foundation...'
sudo apt-get -y --force-yes install curl gnupg software-properties-common wget git gcc g++ make build-essential python-setuptools zsh unzip wget software-properties-common nodejs zsh-syntax-highlighting

# install troublesome ones
echo ":: Installing Additional Stuff"
sudo apt-get -y install fonts-firacode glow 

# install nvm
echo ":: Installing Node Version Manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

echo ':: Fixing Broken Installs'
sudo apt-get -y --fix-broken install

# remove any old packages
sudo apt autoremove

# finaly, print the SSH key so we can add it to github...
echo "***************SSH KEY HERE "
cat ~/.ssh/id_ed25519.pub
echo "*****************************" 

# oh-my-zsh
echo ":: Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
