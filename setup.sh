USER_NAME="Vinay Jain"
USER_EMAIL=$(/usr/libexec/PlistBuddy -c "print :Accounts:0:AccountID" ~/Library/Preferences/MobileMeAccounts.plist)

# Setup Vim
echo "Setting Up Vim"
cp -r .vim $HOME/.vim
cp .vimrc $HOME/.vimrc

# Setup Xcode
echo "Setup Xcode"
THEME_DIR=$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/
mkdir -p "$THEME_DIR"
cp Xcode/Themes/* $THEME_DIR

# Configure Git
git config --global user.name $USER_NAME
git config --global user.email "$USER_EMAIL"

# Install Homebrew if not present

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Brew is already installed. Updating Homebrew"
    brew update
fi

# Install brew packages

echo "Installing apps and fonts"

brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono
brew install --cask brave-browser
brew install --cask raycast
brew install --cask google-chrome
brew install gifski
brew install android-platform-tools
brew install --cask private-internet-access
brew install --cask proxyman
brew install --cask slack
brew install --cask sourcetree
brew install --cask fork
brew install --cask sublime-text
brew install --cask visual-studio-code
brew install --cask zoomus
brew install --cask vlc

# Setup zsh
echo "Setup ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
brew install zsh-syntax-highlighting

cp .zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing Ruby"
echo "Setup rbenv"
brew install openssl@1.1
brew install rbenv
rbenv init

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"
RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $RUBY_VERSION
rbenv local $RUBY_VERSION


source ~/.zshrc