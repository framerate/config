echo '>> SETTING USER PW <<'
sudo passwd ubuntu

echo '>> SETTING USER SSH KEY <<'
ssh-keygen -t rsa -b 4096 -C "<email>"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# set the local time
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# setup MongoDB repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Node 5.X
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

# update
sudo apt-get update

# install everything
sudo apt-get -y --force-yes install git gcc make build-essential python-setuptools nodejs zsh unzip wget software-properties-common mongodb-org

# start mongo!
sudo service mongod start

# finaly, print the SSH key so we can add it to github...
cat ~/.ssh/id_rsa.pub

# install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
