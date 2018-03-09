#!/bin/bash
if [ "$1" = "" ]
then
  echo "Usage: $0 Must pass EMAIL_ADDRESS as first argument!"
  exit
fi

echo '>> SETTING USER PW <<'
sudo passwd ubuntu

echo '>> SETTING USER SSH KEY <<'
ssh-keygen -t rsa -b 4096 -C $1
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# set the local time
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Node 8.X
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# update
sudo apt-get update

# install everything
sudo apt-get -y --force-yes install git gcc make build-essential python-setuptools nodejs zsh unzip wget software-properties-common nginx

# finaly, print the SSH key so we can add it to github...
cat ~/.ssh/id_rsa.pub

# install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
