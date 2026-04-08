#!/usr/bin/env bash
#
# Quick Install Script for wallpaper-picker
# Usage: curl -fsSL https://raw.githubusercontent.com/shadowarch/wallpaper-picker/main/install.sh | bash

set -euo pipefail

REPO="shadowarch/wallpaper-picker"
INSTALL_DIR="$HOME/.local"
BIN_DIR="$INSTALL_DIR/bin"
CONFIG_DIR="$HOME/.config/wallpaper-picker"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Check dependencies
check_deps() {
    local missing=()
    
    for dep in curl git; do
        command -v "$dep" >/dev/null 2>&1 || missing+=("$dep")
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        error "Missing dependencies: ${missing[*]}"
        echo "Install with: sudo pacman -S ${missing[*]}"
        exit 1
    fi
}

# Check required packages
check_required() {
    local missing=()
    
    command -v mpvpaper >/dev/null 2>&1 || missing+=("mpvpaper")
    command -v fzf >/dev/null 2>&1 || missing+=("fzf")
    command -v mpv >/dev/null 2>&1 || missing+=("mpv")
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        warn "Some dependencies are missing:"
        echo ""
        for pkg in "${missing[@]}"; do
            echo "  • $pkg"
        done
        echo ""
        echo "Install with:"
        echo "  sudo pacman -S fzf mpv"
        echo "  yay -S mpvpaper"
        echo ""
        read -p "Continue anyway? [y/N] " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
    fi
}

# Install script
install_script() {
    info "Installing wallpaper-picker..."
    
    mkdir -p "$BIN_DIR"
    mkdir -p "$CONFIG_DIR"
    
    # Download latest version
    local url="https://raw.githubusercontent.com/$REPO/main/wallpaper-picker"
    
    if curl -fsSL "$url" -o "$BIN_DIR/wallpaper-picker"; then
        chmod +x "$BIN_DIR/wallpaper-picker"
        info "Installed to $BIN_DIR/wallpaper-picker"
    else
        error "Failed to download wallpaper-picker"
        exit 1
    fi
}

# Create default config
create_config() {
    if [[ ! -f "$CONFIG_DIR/config" ]]; then
        cat > "$CONFIG_DIR/config" <<'EOF'
# Wallpaper Picker Configuration
MONITOR=""
AUTO_DETECT_MONITOR="yes"
DEFAULT_WALLPAPER_DIR="$HOME/Videos/wallpapers"
ENABLE_AUDIO="no"
LOOP_MODE="inf"
SLIDESHOW_INTERVAL=30
SLIDESHOW_SHUFFLE="no"
THUMBNAIL_ENABLED="yes"
CACHE_THUMBNAILS="yes"
NOTIFICATIONS_ENABLED="yes"
STARTUP_MODE="manual"
EOF
        info "Created default config at $CONFIG_DIR/config"
    fi
}

# Add to PATH check
add_to_path() {
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        warn "$BIN_DIR is not in your PATH"
        echo ""
        echo "Add this to your ~/.bashrc or ~/.zshrc:"
        echo ""
        echo -e "  ${GREEN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
        echo ""
    fi
}

# Main
main() {
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║     Wallpaper Picker Installer        ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    
    check_deps
    check_required
    install_script
    create_config
    add_to_path
    
    echo ""
    info "Installation complete!"
    echo ""
    echo "Run 'wallpaper-picker --help' to get started"
    echo "Run 'wallpaper-picker doctor' to check dependencies"
    echo ""
}

main "$@"
