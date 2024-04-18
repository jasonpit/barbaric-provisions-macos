#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install applications
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask microsoft-edge 
brew install --cask google-chrome
brew install --cask firefox
brew install --cask krita
brew install --cask powershell
brew install --cask inkscape
brew install --cask vlc
brew install --cask nomachine
brew install awscli
brew install azure-cli
brew install --cask skype
brew install --cask whatsapp
brew install --cask zerotier-one
brew install --cask zoom
brew install --cask cyberduck
brew install --cask balenaetcher
brew install --cask the-unarchiver
brew install --cask transmission
brew install --cask microsoft-remote-desktop
brew install onedrive
brew install --cask microsoft-onenote
brew install --cask snagit
brew install --cask airfoil
brew install docker
brew install --cask steam
brew install --cask carbon-copy-cloner
brew install --cask bespoke
brew install --cask hydrogen
brew install --cask caffeine
brew install --cask chromium
brew install --cask fluid
brew install --cask gas-mask
brew install --cask google-web-designer
brew install --cask android-commandlinetools
brew install --cask android-file-transfer
brew install --cask android-platform-tools
brew install --cask androidtool
brew install --cask angry-ip-scanner
brew isntall --cask ffmpeg
brew isntall --cask git
brew install gh
brew install --cask microsoft-teams
brew install --cask slack

#### ohmyzsh installation 

# Check and install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Setup custom aliases
ALIAS_FILE="$HOME/.oh-my-zsh/custom/aliases.zsh"
if [ ! -f "$ALIAS_FILE" ]; then
    touch "$ALIAS_FILE"
fi

cat >> "$ALIAS_FILE" <<EOF
#### zsh aliases 
## list all properly like in Linux.
alias ll='ls -al'
## open my alias file in vim (quick way to add or view current aliases) 
alias aliases='vim ~/.oh-my-zsh/custom/aliases.zsh'
## run apple softwareupdates and then run brew updates.
alias update='sudo softwareupdate -ia --verbose && brew upgrade'
## give me all of my IP addresses, internal LAN and WIFI as well as external.
alias ip='curl ifconfig.co && ipconfig getifaddr en0 && ipconfig getifaddr en1'
## give me a random comoplex password
alias pw='openssl rand -base64 32'
EOF

echo "Aliases have been added to $ALIAS_FILE"
# Ensure the alias file is sourced by .zshrc
if ! grep -q "source $ALIAS_FILE" "$HOME/.zshrc"; then
    echo "source $ALIAS_FILE" >> "$HOME/.zshrc"
fi

# Add some blank spaces to the macOS Dock
for i in {1..5}; do
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
done
killall Dock

# Change the default location for screenshots
mkdir -p "$HOME/Pictures/ScreenShots"
defaults write com.apple.screencapture location "$HOME/Pictures/ScreenShots"
killall SystemUIServer

# Finder Preferences
osascript <<EOD
tell application "Finder"
    -- Set Finder preferences for desktop and sidebar
    set desktop shows hard disks to false
    set desktop shows external hard disks to false
    set desktop shows removable media to false
    set desktop shows connected servers to false

    -- Finder sidebar preferences: Enable all sidebar items
    set sidebar width of window 1 to 200
    set statusbar visible of window 1 to true
    set toolbar visible of window 1 to true
    set sidebar visible of window 1 to true
    set pathbar visible of window 1 to true
    set preview pane visible of window 1 to true

    -- Close and reopen Finder to apply settings
    close every window
end tell
EOD

echo "Installation and configuration complete."

