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
git config --global init.defaultBranch "main"
git config --global pull.rebase true

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

export HOMEBREW_NO_AUTO_UPDATE=1

# Install brew packages

echo "Installing apps and fonts"
brew tap homebrew/cask-fonts

casks=(
    'android-file-transfer'
    'appcleaner'
    'brave-browser'
    'calibre'
    'db-browser-for-sqlite'
    'figma'
    'font-jetbrains-mono'
    'fork'
    'google-chrome'
    'postman'
    'private-internet-access'
    'proxyman'
    'raspberry-pi-imager'
    'raycast'    
    'slack'
    'sourcetree'
    'sublime-text'
    'visual-studio-code'
    'vlc'
    'xcodes'
    'zoomus'
    'chromedriver'
)

for cask in "${casks[@]}" ;do
    brew install --cask $cask
done

formulaes=(
    'android-platform-tools'
    'git'
    'git-lfs'
    'gifski'
    'go'
    'vapor'    
)

for formula in "${formulaes[@]}" ;do
    brew install $formula
done

# Setup zsh
echo "Setup ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cp .zshrc $HOME/.zshrc

echo "Installing pyenv"

brew install pyenv
eval "$(pyenv init -)"
PY_VERSION=$(pyenv install --list | egrep '^\s+\d+.\d+.\d+$' | tail -1 | sed -e 's/^[ \t]*//')
pyenv install $PY_VERSION
pyenv local $PY_VERSION

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
