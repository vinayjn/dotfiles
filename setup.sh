# Install Homebrew if not present

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Brew is already installed. Updating Homebrew"
    brew update
fi

# Setup Vim
echo "Setting Up Vim"
cp -r .vim ~/.vim
cp .vimrc ~/.vimrc


