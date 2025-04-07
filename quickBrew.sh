#!/bin/bash
# Check for Bash version 4 or later and auto-install Bash if needed
if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "Your Bash version is ${BASH_VERSINFO[0]}. This script requires Bash 4.0 or later."
    
    # Install Homebrew if it's not installed
    if ! command -v brew &>/dev/null; then
         echo "Homebrew is not installed. Installing Homebrew first..."
         /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Homebrew installation failed!"; exit 1; }
         eval "$($(/opt/homebrew/bin/brew shellenv))"
         echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
    
    echo "Installing Bash..."
    brew install bash || { echo "Failed to install Bash"; exit 1; }
    new_bash="$(brew --prefix bash)/bin/bash"
    echo "New Bash installed at $new_bash"
    echo "Re-launching script with new Bash..."
    exec "$new_bash" "$0" "$@"
fi
### A script to set up a new Mac ###
### Author: Jason Pittman ###
### Version: 1.3 (Updated 2025-03-31) ###

clear
cat << "EOF"
                     .8 
                      .888
                    .8888'
                   .8888'
                   888'
                   8'
      .88888888888. .88888888888.
   .8888888888888888888888888888888.
 .8888888888888888888888888888888888.
.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
`%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
 `00000000000000000000000000000000000'
  `000000000000000000000000000000000'
   `0000000000000000000000000000000'
     `###########################'
      `#######################'
         `#########''########'
           `""""""'  `"""""'
EOF

echo "🔥 Dude! Get ready for all your software! 🔥"
sleep 3

echo "Starting macOS setup script..."
# Set custom screenshot location
SCREENSHOT_DIR="/Users/jason/Pictures/ScreenShots"
mkdir -p "$SCREENSHOT_DIR"
defaults write com.apple.screencapture location "$SCREENSHOT_DIR"
killall SystemUIServer
# Create GitHub folder in ~/Documents and create a symlink in ~/ "helps auto sync with iCloud or OneDrive by being in ~/Documents"
GITHUB_DIR="$HOME/Documents/GitHub"
mkdir -p "$GITHUB_DIR"
ln -sfn "$GITHUB_DIR" "$HOME/GitHub"

echo "💾 Reminder: Store important files in OneDrive or cloud storage for easy recovery! 🚀"

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        echo "❌ Homebrew installation failed!"; exit 1;
    }
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
else
    echo "✅ Homebrew is already installed. Updating..."
    brew update && brew upgrade && brew doctor

    # Ensure HashiCorp tap is added for HashiCorp tools
    if ! brew tap | grep -q "hashicorp/tap"; then
        echo "Tapping hashicorp/tap for HashiCorp tools..."
        brew tap hashicorp/tap
    fi
fi

# Backup Finder preferences
FINDER_PLIST=~/Library/Preferences/com.apple.finder.plist
if [ -f "$FINDER_PLIST" ]; then
    cp "$FINDER_PLIST" ~/Desktop/com.apple.finder.plist.backup
    echo "✅ Finder preferences backed up!"
else
    echo "⚠️ Finder preferences not found, skipping backup."
fi

# List of software to install
declare -A SOFTWARE_PACKAGES=(
    ["Development & CLI Tools"]="awscli azure-cli docker gh git php mysql node azcopy terraform"
    ["Web Browsers"]="microsoft-edge google-chrome firefox chromium google-chrome-canary brave-browser"
    ["Design & Media"]="krita inkscape vlc ffmpeg snagit airfoil"
    ["Communication"]="skype whatsapp zoom slack microsoft-teams"
    ["Utilities & System Tools"]="cyberduck balenaetcher the-unarchiver steam transmission"
    ["Android Development"]="android-commandlinetools android-file-transfer android-platform-tools scrcpy"
    ["Terminal & Networking"]="iterm2 nomachine zerotier-one angry-ip-scanner"
    ["Audio & Music"]="native-access"
)



# Function to prompt for confirmation
confirm_install() {
    read -p "Do you want to install $1? (y/n) " choice
    [[ "$choice" =~ ^[Yy]$ ]]
}

# Install software
for category in "${!SOFTWARE_PACKAGES[@]}"; do
    if confirm_install "$category"; then
        for package in ${SOFTWARE_PACKAGES[$category]}; do
            # Check if the package is available as a cask
            if brew info --cask "$package" > /dev/null 2>&1; then
                echo "Installing $package as a cask..."
                brew install --cask "$package"
            else
                echo "Installing $package as a formula..."
                brew install "$package"
            fi
        done
        echo "✅ $category installed!"
    else
        echo "❌ Skipping $category"
    fi
done

# Oh My Zsh installation
if confirm_install "Oh My Zsh" && [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Oh My Zsh installed!"
else
    echo "❌ Skipping Oh My Zsh installation"
fi

# Custom Aliases
if confirm_install "Custom Aliases"; then
    ALIAS_FILE="$HOME/.oh-my-zsh/custom/aliases.zsh"
    mkdir -p "$(dirname "$ALIAS_FILE")"
    cat > "$ALIAS_FILE" <<EOF
alias ll='ls -al'
alias la='ls -a'
alias update='sudo softwareupdate -ia --verbose && brew upgrade'
alias ip='echo "Public IPv4: $(curl -s ifconfig.co)" && ipconfig getifaddr en0'
alias pw='openssl rand -base64 16'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias weather='curl -s wttr.in'
EOF
    echo "source $ALIAS_FILE" >> "$HOME/.zshrc"
    echo "✅ Custom Aliases configured!"
else
    echo "❌ Skipping Custom Aliases setup"
fi

# Finder Customization  
if confirm_install "Finder Customization"; then
    defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    killall Finder
    echo "✅ Finder customized!"
else
    echo "❌ Skipping Finder customization"
fi

# Dock Customization
if confirm_install "macOS Dock Customization"; then
    # Preserve existing dock items (do not clear them)
    # If you wish to clear the Dock items, uncomment the next line
    # defaults write com.apple.dock persistent-apps -array
    
    # Optionally add spacer tiles without removing current items
    for i in {1..6}; do
        defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    done
    defaults write com.apple.dock mineffect -string scale
    killall Dock
    echo "✅ Dock customized!"
else
    echo "❌ Skipping Dock customization"
fi

# Cleanup
if confirm_install "Homebrew Cleanup"; then
    brew cleanup
    echo "✅ Cleanup complete!"
else
    echo "❌ Skipping Cleanup"
fi

echo "🎉 Installation and configuration complete!"
