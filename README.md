# macOS Setup Script

### A script to set up a new Mac

**Author:** Jason Pittman  
**Version:** 1.3 (Updated 2025-03-31)

---

## Overview

This script automates the installation and configuration of essential software, development tools, and system preferences on macOS. It’s designed to get your new (or refreshed) Mac up and running quickly with minimal manual intervention.

The script performs the following tasks:

- **Bash Upgrade:**  
  Checks if the current Bash version is below 4.0. If so, it will:
  - Install Homebrew (if not already installed)
  - Use Homebrew to install the latest Bash
  - Re-launch itself using the newly installed Bash

- **Homebrew Management:**  
  - Automatically installs Homebrew if it’s not installed.
  - Updates Homebrew, upgrades installed formulae, and runs `brew doctor` if Homebrew is already installed.
  - Adds the HashiCorp tap for tools like Terraform if not already present.

- **System Backup & Customization:**  
  - Backs up Finder preferences to your Desktop.
  - Customizes Finder (e.g., setting Column View, enabling the Path Bar and Status Bar).
  - Customizes the Dock by adding six spacer tiles without clearing existing items.

- **Software Installation:**  
  The script uses an associative array to organize software into categories. For each category, it prompts you for confirmation before proceeding with installation. It distinguishes between Homebrew formulae and casks automatically.
  
  The current categories and their packages include:

  - **Development & CLI Tools:**  
    `awscli`, `azure-cli`, `docker`, `gh`, `git`, `php`, `mysql`, `node`, `azcopy`, `terraform`
  
  - **Web Browsers:**  
    `microsoft-edge`, `google-chrome`, `firefox`, `chromium`, `google-chrome-canary`, `brave-browser`
  
  - **Design & Media:**  
    `krita`, `inkscape`, `vlc`, `ffmpeg`, `snagit`, `airfoil`
  
  - **Communication:**  
    `skype`, `whatsapp`, `zoom`, `slack`, `microsoft-teams`
  
  - **Utilities & System Tools:**  
    `cyberduck`, `balenaetcher`, `the-unarchiver`, `steam`, `transmission`
  
  - **Android Development:**  
    `android-commandlinetools`, `android-file-transfer`, `android-platform-tools`, `scrcpy`
  
  - **Terminal & Networking:**  
    `iterm2`, `nomachine`, `zerotier-one`, `angry-ip-scanner`
  
  - **Audio & Music:**  
    `native-access`

- **Additional Features:**  
  - **Oh My Zsh Installation:**  
    Installs Oh My Zsh if you choose to, along with custom shell aliases.
  
  - **Homebrew Cleanup:**  
    Optionally cleans up outdated Homebrew packages at the end of the script.

- **User Interaction:**  
  The script is interactive—it will prompt you to confirm whether to install each category, giving you full control over what gets installed.

