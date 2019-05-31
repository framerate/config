if [ "$1" = "" ]
then
          echo "Usage: $0 Must pass EMAIL_ADDRESS as first argument!"
            exit
    fi

    echo '>> SETTING USER PW <<'
    sudo passwd $USER

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
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

    # install everything
    echo "*** INSTALLING FOUNDATION ***"
    sudo apt-get -y --force-yes install git gcc g++ make build-essential python-setuptools zsh unzip wget software-properties-common

    # Atom
    wget "https://atom.io/download/deb" -O atom-amd64.deb
    sudo dpkg -i atom-amd64.deb

    # update
    sudo apt-get update
    
    # install troublesome ones
    echo "*** INSTALLING TROUBLESOME STUFF ***"
    sudo apt-get -y install mongodb nodejs atom

    # fix it
    echo "*** FIXING BROKEN INSTALLS ***"    
    sudo apt-get -y --fix-broken install
    
    # install nvm
    echo "*** INSTALL NVM ***"    
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

    # finaly, print the SSH key so we can add it to github...
    cat ~/.ssh/id_rsa.pub

    # install zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
