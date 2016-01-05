echo '>> SETTING USER PW <<'
sudo passwd ubuntu

echo '>> SETTING USER SSH KEY <<'
ssh-keygen -t rsa -b 4096 -C "framerate@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# Node 4.X
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

# ansible
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y --force-yes install git gcc make build-essential python-setuptools nodejs zsh unzip wget software-properties-common ansible

# packer stuff
cd ~/
mkdir packer
cd packer
wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip
unzip packer_0.8.6_linux_amd64.zip
export PATH=$PATH:/home/ubuntu/packer

# pip
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install awscli

# finaly, print the SSH key so we can add it to github...

aws configure
cat ~/.ssh/id_rsa.pub

echo '>>>>>>>>>> DONT FORGET TO SETUP TROPOSPHERE pip install troposphere==0.7.1 <<<<<<<<<<<<<<<<'
# install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
