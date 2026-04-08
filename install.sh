#!/usr/bin/env bash
#
# =============================================================================
# ███████╗██╗   ██╗██████╗ ██████╗  █████╗ ██████╗ 
# ██╔════╝██║   ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗
# ███████╗██║   ██║██████╔╝██████╔╝███████║██████╔╝
# ╚════██║██║   ██║██╔══██╗██╔══██╗██╔══██║██╔══██╗
# ███████║╚██████╔╝██████╔╝██████╔╝██║  ██║██████╔╝
# ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ 
# =============================================================================
#
# Quick Install Script for wallpaper-picker
# Supports Arch Linux, Manjaro, EndeavourOS, and other Arch derivatives
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/install.sh | bash
#
# =============================================================================

set -euo pipefail

# Configuration
readonly REPO="5h4d0wn1k/wallpaper-picker"
readonly RAW_URL="https://raw.githubusercontent.com/${REPO}/main"
readonly INSTALL_DIR="${HOME}/.local"
readonly BIN_DIR="${INSTALL_DIR}/bin"
readonly CONFIG_DIR="${HOME}/.config/wallpaper-picker"
readonly SHARE_DIR="${INSTALL_DIR}/share/wallpaper-picker"

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'
readonly BOLD='\033[1m'

# Emoji
readonly CHECK="${GREEN}✓${NC}"
readonly CROSS="${RED}✗${NC}"
readonly INFO="${CYAN}○${NC}"
readonly WARN="${YELLOW}!${NC}"

# Functions
info() { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# Check if running on Arch Linux
check_arch() {
    if [[ ! -f /etc/arch-release ]] && ! command -v pacman &>/dev/null; then
        warn "This script is designed for Arch Linux-based distributions."
        warn "It may work on other distributions but is not officially supported."
        return 1
    fi
    return 0
}

# Check dependencies
check_dependencies() {
    local missing=()
    
    # Required
    command -v pacman &>/dev/null || missing+=("pacman")
    
    # Optional (will install)
    command -v git &>/dev/null || missing+=("git")
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        error "Missing required tools: ${missing[*]}"
        return 1
    fi
    return 0
}

# Install system dependencies
install_dependencies() {
    info "Installing system dependencies..."
    
    local packages=(
        "fzf"           # Fuzzy finder for TUI
        "mpv"           # Media player
        "jq"            # JSON processing
        "ffmpeg"        # Video thumbnails
        "libnotify"     # Notifications
    )
    
    # Check for mpvpaper in AUR
    if ! pacman -Qs "^mpvpaper$" &>/dev/null && ! command -v mpvpaper &>/dev/null; then
        packages+=("mpvpaper")
        warn "mpvpaper is in AUR and will be installed via yay/paru"
    fi
    
    # Try pacman first
    if sudo pacman -Sy --noconfirm "${packages[@]}" 2>/dev/null; then
        success "System packages installed"
    else
        warn "Some packages need AUR helper. Trying yay/paru..."
        install_aur_helper
    fi
}

# Install AUR helper
install_aur_helper() {
    if command -v yay &>/dev/null || command -v paru &>/dev/null; then
        local aur_helper
        command -v yay &>/dev/null && aur_helper="yay" || aur_helper="paru"
        info "Using $aur_helper to install AUR packages..."
        sudo "$aur_helper" -Sy --noconfirm mpvpaper fzf mpv jq ffmpeg libnotify
    else
        info "Installing yay..."
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
        yay -Sy --noconfirm mpvpaper fzf mpv jq ffmpeg libnotify
    fi
}

# Download file from GitHub
download_file() {
    local file="$1"
    local dest="$2"
    
    info "Downloading $file..."
    if curl -fsSL "${RAW_URL}/${file}" -o "$dest"; then
        success "Downloaded $file"
        return 0
    else
        error "Failed to download $file"
        return 1
    fi
}

# Install wallpaper-picker
install_wallpaper_picker() {
    info "Installing wallpaper-picker..."
    
    # Create directories
    mkdir -p "$BIN_DIR"
    mkdir -p "$CONFIG_DIR"
    mkdir -p "${HOME}/.local/share/applications"
    mkdir -p "${HOME}/.local/share/icons"
    
    # Download main script
    download_file "src/wallpaper-picker" "${BIN_DIR}/wallpaper-picker"
    chmod +x "${BIN_DIR}/wallpaper-picker"
    
    # Download GUI script
    download_file "src/wallpaper-picker-gui" "${BIN_DIR}/wallpaper-picker-gui"
    chmod +x "${BIN_DIR}/wallpaper-picker-gui"
    
    # Download desktop entry
    download_file "desktop/wallpaper-picker.desktop" "${HOME}/.local/share/applications/wallpaper-picker.desktop"
    
    # Download icon
    download_file "icons/wallpaper-picker.svg" "${HOME}/.local/share/icons/wallpaper-picker.svg"
    
    # Create default config if not exists
    if [[ ! -f "${CONFIG_DIR}/config" ]]; then
        cat > "${CONFIG_DIR}/config" <<'EOF'
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
PREVIEW_ENABLED="yes"
PREVIEW_TIMEOUT=3
EOF
        success "Created default configuration"
    fi
    
    # Update desktop database
    update-desktop-database "${HOME}/.local/share/applications/" 2>/dev/null || true
}

# Verify installation
verify_installation() {
    info "Verifying installation..."
    
    local issues=0
    
    # Check binary
    if [[ -x "${BIN_DIR}/wallpaper-picker" ]]; then
        success "wallpaper-picker installed"
    else
        error "wallpaper-picker not found or not executable"
        ((issues++))
    fi
    
    # Check GUI binary
    if [[ -x "${BIN_DIR}/wallpaper-picker-gui" ]]; then
        success "wallpaper-picker-gui installed"
    else
        warn "wallpaper-picker-gui not found (optional, requires GTK4)"
        ((issues++))
    fi
    
    # Check desktop entry
    if [[ -f "${HOME}/.local/share/applications/wallpaper-picker.desktop" ]]; then
        success "Desktop entry installed"
    else
        warn "Desktop entry not found"
        ((issues++))
    fi
    
    # Test wallpaper-picker
    if "${BIN_DIR}/wallpaper-picker" --version &>/dev/null; then
        success "wallpaper-picker works"
    else
        error "wallpaper-picker test failed"
        ((issues++))
    fi
    
    return $issues
}

# Add to PATH
add_to_path() {
    local bashrc="${HOME}/.bashrc"
    local zshrc="${HOME}/.zshrc"
    local path_line='export PATH="$HOME/.local/bin:$PATH"'
    
    # Check if already in bashrc
    if [[ -f "$bashrc" ]] && grep -q "\.local/bin" "$bashrc"; then
        info "PATH already configured in .bashrc"
    else
        echo "" >> "$bashrc"
        echo "# Add ~/.local/bin to PATH" >> "$bashrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$bashrc"
        success "Added to .bashrc"
    fi
    
    # Check if already in zshrc
    if [[ -f "$zshrc" ]] && grep -q "\.local/bin" "$zshrc"; then
        info "PATH already configured in .zshrc"
    else
        echo "" >> "$zshrc"
        echo "# Add ~/.local/bin to PATH" >> "$zshrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$zshrc"
        success "Added to .zshrc"
    fi
}

# Print success message
print_success() {
    echo ""
    echo -e "${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║         Wallpaper Picker Installation Complete!        ║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${CHECK} ${GREEN}wallpaper-picker installed successfully${NC}"
    echo ""
    echo -e "  ${BOLD}Quick Usage:${NC}"
    echo -e "    ${CYAN}wallpaper-picker pick${NC}       - Interactive TUI picker"
    echo -e "    ${CYAN}wallpaper-picker gui${NC}        - GTK4 GUI picker"
    echo -e "    ${CYAN}wallpaper-picker random${NC}     - Random wallpaper"
    echo -e "    ${CYAN}wallpaper-picker slideshow${NC}  - Slideshow mode"
    echo ""
    echo -e "  ${BOLD}Menu Integration:${NC}"
    echo -e "    Search for '${BOLD}Wallpaper Picker${NC}' in your app menu"
    echo -e "    Right-click for quick actions (TUI/GUI/Random/Slideshow)"
    echo ""
    echo -e "  ${BOLD}Hyprland Integration:${NC}"
    echo -e "    Add to ${HOME}/.config/hypr/hyprland.conf:"
    echo -e "    ${DIM}bind = SUPER, W, exec, wallpaper-picker pick${NC}"
    echo ""
    echo -e "  ${BOLD}Documentation:${NC}"
    echo -e "    ${CYAN}wallpaper-picker --help${NC}    - Full help"
    echo -e "    ${CYAN}wallpaper-picker doctor${NC}     - Diagnose issues"
    echo ""
    echo -e "  ${BOLD}AUR Package:${NC}"
    echo -e "    Also available via: ${CYAN}yay -S wallpaper-picker${NC}"
    echo ""
}

# Main
main() {
    echo ""
    echo -e "${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║           Wallpaper Picker Installer v2.0.0             ║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Check for Arch Linux
    check_arch || true
    
    # Check dependencies
    check_dependencies || exit 1
    
    # Install dependencies
    install_dependencies || warn "Some dependencies may need manual installation"
    
    # Install wallpaper-picker
    install_wallpaper_picker || { error "Installation failed"; exit 1; }
    
    # Add to PATH
    add_to_path
    
    # Verify installation
    if verify_installation; then
        print_success
    else
        warn "Installation completed with some issues"
        echo "Please check the output above for details"
    fi
}

# Run
main "$@"
