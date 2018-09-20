
if [ "$1" = "" ]
then
          echo "Usage: $0 Must pass EMAIL_ADDRESS as first argument!"
            exit
    fi

    echo '>> SETTING USER PW <<'
    #sudo passwd ubuntu

    echo '>> SETTING USER SSH KEY <<'
    ssh-keygen -t rsa -b 4096 -C $1
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

    # set the local time
    sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

    sudo apt-get update

    sudo apt-get upgrade -y

    sudo apt-get install -y --force-yes gnupg software-properties-common wget

    # Node 8.X
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

    # Atom
    wget https://github.com/atom/atom/releases/download/v1.9.2/atom-amd64.deb
    sudo dpkg -i atom-amd64.deb

    # update
    sudo apt-get update

    # install everything
    sudo apt-get -y --force-yes install git gcc g++ make build-essential python-setuptools nodejs zsh unzip wget software-properties-common mongodb atom

    # finaly, print the SSH key so we can add it to github...
    cat ~/.ssh/id_rsa.pub

    # install zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
