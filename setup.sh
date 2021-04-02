USER_NAME="Vinay Jain"
USER_EMAIL=$(/usr/libexec/PlistBuddy -c "print :Accounts:0:AccountID" ~/Library/Preferences/MobileMeAccounts.plist)

# Install Homebrew if not present

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Brew is already installed. Updating Homebrew"
    brew update
fi

# Install brew packages

echo "Downloading and Installing fonts: Source code pro & Fira Code"
brew tap homebrew/cask-fonts 
brew install --cask font-source-code-pro
brew install --cask font-fira-code

echo "Installing VS Code"
brew install --cask visual-studio-code

echo "Setup rbenv"
brew install openssl
brew install rbenv
rbenv init
source ~/.zshrc

RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $RUBY_VERSION
rbenv local $RUBY_VERSION

echo "Install Android Platform Tools"
brew install android-platform-tools

# Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh-syntax-highlighting
cp .zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Setup Vim
echo "Setting Up Vim"
cp -r .vim $HOME/.vim
cp .vimrc $HOME/.vimrc


# Setup blogging platform
cd /tmp
git clone https://github.com/johnsundell/splash.git
cd splash
make install

# Configure Git
git config user.name $USER_NAME
git config user.email "$USER_EMAIL"