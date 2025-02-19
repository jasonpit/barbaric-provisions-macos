#!/bin/bash
### A script to set up a new Mac ###
### Author: Jason Pittman ###
### Version: 1.2 (Updated 2025-02-03) ###

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

echo "🔥 Dude! Get ready for all your stuff! 🔥"
sleep 3

echo "Starting macOS setup script..."
echo "💾 Reminder: LIVE in your cloud storage! Store your important files in OneDrive (Documents) or another cloud service. If something goes wrong, recovery will be much easier! 🚀"

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Homebrew installation failed!"; exit 1; }
else
    echo "Homebrew is already installed. Updating and upgrading..."
    brew update && brew upgrade
    brew doctor
fi

echo "\n📋 Here’s what’s going to be installed:"
echo "--------------------------------------------------"
echo "📌 Development & CLI Tools: AWS CLI, Azure CLI, Docker, Git, PHP, MySQL, VS Code, Terraform"
echo "📌 Web Browsers: Microsoft Edge, Google Chrome, Firefox, Chromium, Chrome Canary, Brave"
echo "📌 Design & Media: Krita, Inkscape, VLC, Google Web Designer"
echo "📌 Communication: Skype, WhatsApp, Zoom, Slack, Microsoft Teams"
echo "📌 Utilities & System Tools: Cyberduck, Balena Etcher, The Unarchiver, ZeroTier One, Steam, Angry IP Scanner, Transmission"
echo "📌 Android Development: Android Platform Tools, Scrcpy, File Transfer"
echo "📌 Terminal & Networking: iTerm2, NoMachine"
echo "📌 Oh My Zsh Custom Shell"
echo "📌 Custom OhMyzsh Aliases for CLI shortcuts - like > get your IP's, password generator, updated everything"
echo "📌 macOS Dock Customization & Finder Preferences"
echo "📌 Homebrew Cleanup"
echo "--------------------------------------------------"
sleep 5

#### Function to prompt user for confirmation ####
confirm_install() {
    read -p "Do you want to install $1? (y/n) " choice
    case "$choice" in 
        y|Y ) return 0 ;;  # Proceed
        * ) return 1 ;;     # Skip
    esac
}

#### Installation Process ####
echo "Installing applications..."

#### Development & CLI Tools ####
if confirm_install "Development & CLI Tools"; then
    brew install awscli azure-cli docker gh git php mysql node
    brew install --cask visual-studio-code powershell onedrive omnissa-horizon-client windows-app gimme-aws-creds
    brew tap hashicorp/tap && brew install hashicorp/tap/terraform
    echo "✅ Development & CLI Tools installed!"
else
    echo "❌ Skipping Development & CLI Tools"
fi

#### Web Browsers ####
if confirm_install "Web Browsers"; then
    brew install --cask microsoft-edge google-chrome firefox chromium brew google-chrome@canary brave-browser
    echo "✅ Web Browsers installed!"
else
    echo "❌ Skipping Web Browsers"
fi

#### Design & Media ####
if confirm_install "Design & Media Apps"; then
    brew install --cask krita inkscape vlc google-web-designer
    echo "✅ Design & Media apps installed!"
else
    echo "❌ Skipping Design & Media apps"
fi

#### Communication ####
if confirm_install "Communication Apps"; then
    brew install --cask skype whatsapp zoom slack microsoft-teams
    echo "✅ Communication apps installed!"
else
    echo "❌ Skipping Communication apps"
fi

#### Utilities & System Tools ####
if confirm_install "Utilities & System Tools"; then
    brew install --cask cyberduck balenaetcher the-unarchiver steam transmission
    echo "✅ Utilities & System Tools installed!"
else
    echo "❌ Skipping Utilities & System Tools"
fi

#### Android Development ####
if confirm_install "Android Development Tools"; then
    brew install --cask android-commandlinetools android-file-transfer android-platform-tools scrcpy
    echo "✅ Android Development Tools installed!"
else
    echo "❌ Skipping Android Development Tools"
fi

#### Terminal & Networking ####
if confirm_install "Terminal & Networking Tools"; then
    brew install --cask iterm2 nomachine zerotier-one angry-ip-scanner
    echo "✅ Terminal & Networking tools installed!"
else
    echo "❌ Skipping Terminal & Networking tools"
fi

#### Oh My Zsh Installation ####
if confirm_install "Oh My Zsh"; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "✅ Oh My Zsh installed!"
    else
        echo "Oh My Zsh is already installed."
    fi
else
    echo "❌ Skipping Oh My Zsh installation"
fi

#### Custom Aliases ####
if confirm_install "Custom Aliases"; then
    ALIAS_FILE="$HOME/.oh-my-zsh/custom/aliases.zsh"
    cat > "$ALIAS_FILE" <<EOF
alias ll='ls -al'
alias aliases='vim ~/.oh-my-zsh/custom/aliases.zsh'
alias update='sudo softwareupdate -ia --verbose && brew upgrade && brew cleanup'
alias ip='curl ifconfig.co && ipconfig getifaddr en0 && ipconfig getifaddr en1'
alias pw='openssl rand -base64 32'
EOF
    echo "source $ALIAS_FILE" >> "$HOME/.zshrc"
    echo "✅ Custom Aliases configured!"
else
    echo "❌ Skipping Custom Aliases setup"
fi

#### macOS Dock Customization ####
if confirm_install "macOS Dock Customization"; then
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    defaults write com.apple.dock mineffect -string scale
    killall Dock
    echo "✅ Dock customized!"
else
    echo "❌ Skipping Dock customization"
fi

#### Cleanup ####
if confirm_install "Homebrew Cleanup"; then
    brew cleanup
    echo "✅ Cleanup complete!"
else
    echo "❌ Skipping Cleanup"
fi

echo "🎉 Installation and configuration complete!"
