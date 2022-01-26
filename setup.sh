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

echo "Setup rbenv"
brew install openssl@1.1
brew install rbenv
rbenv init

# Setup zsh
echo "Setup ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh-syntax-highlighting
cp .zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

source ~/.zshrc


echo "Installing Ruby"

RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $RUBY_VERSION
rbenv local $RUBY_VERSION


# Setup Vim
echo "Setting Up Vim"
cp -r .vim $HOME/.vim
cp .vimrc $HOME/.vimrc


# Configure Git
git config user.name $USER_NAME
git config user.email "$USER_EMAIL"


# Install brew packages

echo "Installing apps and fonts"
brew tap homebrew/cask-fonts 
brew install --cask font-source-code-pro
brew install --cask font-fira-code

brew install --cask alfred
brew install --cask google-chrome
brew install gifski
brew install android-platform-tools
brew install --cask private-internet-access
brew install --cask proxyman
brew install --cask slack
brew install --cask sourcetree
brew install --cask sublime-text
brew install --cask sublime-merge
brew install --cask visual-studio-code
brew install --cask zoomus