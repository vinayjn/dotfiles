# Install Homebrew if not present

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Brew is already installed. Updating Homebrew"
    brew update
fi

# Install brew packages

echo "Installing iterm2"
brew cask install iterm2

echo "Downloading and Installing font: Source code pro"
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro

# Setup zsh
echo "Setting Up zsh"
brew install zsh
sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh-syntax-highlighting
cp .zshrc $HOME/.zshrc

# Setup Vim
echo "Setting Up Vim"
cp -r .vim $HOME/.vim
cp .vimrc $HOME/.vimrc

echo "Installing Sublime Text"
brew cask install sublime-text

echo "Installing Java"
brew cask install java

echo "Installing buck"
brew tap facebook/fb
brew install buck
