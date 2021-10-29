if [[ $EUID == 0 ]]; then export SUDO=""; else # Check if we are root
  export SUDO="sudo";
fi

echo "Installing AWS CLI v2"
if uname -a | grep Darwin > /dev/null 2>&1; then
    cd /tmp || { echo "Not able to access /tmp"; return; }
    git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
    brew install zlib openssl readline
    CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib" ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer >/dev/null 2>&1
    return $?
elif uname -a | grep Linux > /dev/null 2>&1; then
    $SUDO apt-get -qq update > /dev/null
    # these are the system level deps for the ebcli
    $SUDO apt-get -qq -y install build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev
    if [ "$(which python3 | tail -1)" ]; then
        echo "Python3 env found"
    else
        echo "Python3 env not found, setting up python with apt"
    fi
fi
    pipx install awsebcli
    echo "AWS CLI is already installed, skipping installation."
    eb --version