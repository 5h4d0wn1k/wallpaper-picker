#!/usr/bin/env bash
# Debian/Ubuntu Install Script
set -euo pipefail

echo "Installing Wallpaper Picker for Debian/Ubuntu..."

# Check for mpvpaper alternative (wlrmbg works on more distros)
install_wallpaper_backend() {
    if command -v apt-get &>/dev/null; then
        if ! command -v mpvpaper &>/dev/null; then
            echo "Installing wlrmbg (mpvpaper alternative)..."
            # Try to build from source or use alternative
            sudo apt-get update
            sudo apt-get install -y mpv ffmpegthumbnailer fzf jq libnotify-bin
        fi
    fi
}

# Install dependencies
sudo apt-get update
sudo apt-get install -y mpv ffmpegthumbnailer fzf jq libnotify-bin wlrmbg 2>/dev/null || \
sudo apt-get install -y mpv ffmpegthumbnailer fzf jq libnotify-bin

# Create directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/128x128/apps

# Download scripts
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker -o ~/.local/bin/wallpaper-picker
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker-gui -o ~/.local/bin/wallpaper-picker-gui
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/desktop/wallpaper-picker.desktop -o ~/.local/share/applications/wallpaper-picker.desktop
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/icons/128x128.png -o ~/.local/share/icons/hicolor/128x128/apps/wallpaper-picker.png

chmod +x ~/.local/bin/wallpaper-picker ~/.local/bin/wallpaper-picker-gui

# Add to PATH
if ! grep -q "\.local/bin" ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

echo "Done! Run 'wallpaper-picker --help' to get started."
