# macOS Setup Script

## Overview
This script automates the installation and configuration of essential applications, development tools, and system preferences for macOS. Whether setting up a new Mac or refreshing an existing setup, this script streamlines the process. Feel free to contribute!

![macOS Setup](https://freebiesupply.com/logos/apple-computer-rainbow-logo/)

## Features
- **Installs popular development tools** like AWS CLI, Azure CLI, Docker, Git, PHP, MySQL, and Terraform.
- **Sets up web browsers** including Microsoft Edge, Google Chrome, Firefox, and Chromium.
- **Installs design & media applications** such as Krita, Inkscape, VLC, and Google Web Designer.
- **Adds communication & collaboration tools** like Skype, WhatsApp, Zoom, Slack, and Microsoft Teams.
- **Configures utilities & system tools** including Cyberduck, Balena Etcher, ZeroTier One, Steam, and Angry IP Scanner.
- **Installs Android development tools** like Android Platform Tools, Scrcpy, and Android File Transfer.
- **Enhances the terminal experience** with iTerm2, NoMachine, and Oh My Zsh.
- **Configures custom aliases** for common commands and shortcuts.
- **Customizes macOS Dock & Finder preferences** to streamline usability.
- **Performs Homebrew cleanup** to remove outdated packages and free up space.
- **Encourages cloud storage usage** to ensure data protection and easy recovery.

## Installation
### 1. Download and Run the Script
Clone this repository or download the script:
```bash
curl -O https://github.com/wcet-dope-aio/macops/blob/main/quickBrew.sh
chmod +x quickBrew.sh
./quickBrew.sh
```

### 2. Follow the Prompts
The script will ask for confirmation before installing different categories of software. Answer `y` to install or `n` to skip.

## Terminal Output Example
```
🔥 Dude! Get ready for all your stuff! 🔥
📋 Here’s what’s going to be installed:
--------------------------------------------------
📌 Development & CLI Tools: AWS CLI, Azure CLI, Docker, Git, PHP, MySQL, VS Code, Terraform
📌 Web Browsers: Microsoft Edge, Google Chrome, Firefox, Chromium
📌 Design & Media: Krita, Inkscape, VLC, Google Web Designer, Transmission
📌 Communication: Skype, WhatsApp, Zoom, Slack, Microsoft Teams
📌 Utilities & System Tools: Cyberduck, Balena Etcher, The Unarchiver, ZeroTier One, Steam, Angry IP Scanner
📌 Android Development: Android Platform Tools, Scrcpy, File Transfer
📌 Terminal & Networking: iTerm2, NoMachine
📌 Oh My Zsh Custom Shell
📌 Custom Aliases for CLI shortcuts
📌 macOS Dock Customization & Finder Preferences
📌 Homebrew Cleanup
--------------------------------------------------
💾 Reminder: LIVE in your cloud storage! Store your important files in OneDrive (Documents) or another cloud service. If something goes wrong, recovery will be much easier! 🚀
```

## Cloud Storage Reminder
💡 **LIVE in your cloud storage!** Save your important documents in OneDrive, Google Drive, or another cloud service. This makes it easier to recover from unexpected issues and ensures your work is always backed up.

## Notes
- This script is intended for **macOS users** and relies on **Homebrew**.
- If Homebrew is not installed, the script will install it automatically.
- The script prompts users before installing each category of applications.

## Contributing
If you have improvements or want to add more features, feel free to submit a pull request!

## License
This script is open-source and available under the MIT License.

---
**Created by Jason Pittman** - Version 1.2 (Updated 2025-02-03)

