#!/usr/bin/env bash
#
# ╔═══════════════════════════════════════════════════════════════════╗
# ║                    Wallpaper Picker Installer                     ║
# ║         The Ultimate Video Wallpaper Manager for Hyprland         ║
# ╚═══════════════════════════════════════════════════════════════════╝
#
# One-liner installation:
#   curl -fsSL https://git.io/wallpaper-picker | bash
#
# Or with options:
#   curl -fsSL https://git.io/wallpaper-picker | bash -s -- --dir /path/to/wallpapers
#
set -euo pipefail

VERSION="2.2.0"
REPO="5h4d0wn1k/wallpaper-picker"
INSTALL_DIR="${HOME}/.local"
BIN_DIR="${INSTALL_DIR}/bin"
CONFIG_DIR="${HOME}/.config/wallpaper-picker"
DATA_DIR="${HOME}/.local/share/wallpaper-picker"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

err() { echo -e "${RED}[ERROR]${NC} $*" >&2; }
info() { echo -e "${BLUE}[INFO]${NC} $*"; }
ok() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dir) WALLPAPER_DIR="$2"; shift 2 ;;
            --audio) ENABLE_AUDIO="yes"; shift ;;
            --help|-h) usage; exit 0 ;;
            *) shift ;;
        esac
    done
}

usage() {
    cat <<EOF
${BOLD}Wallpaper Picker Installer v${VERSION}${NC}

${BOLD}Usage:${NC}
    curl -fsSL https://git.io/wallpaper-picker | bash
    curl -fsSL https://git.io/wallpaper-picker | bash -s -- [options]

${BOLD}Options:${NC}
    --dir PATH     Set wallpaper directory (default: ~/Videos/wallpapers)
    --audio        Enable audio playback
    --help, -h     Show this help message

${BOLD}Examples:${NC}
    # Default install
    curl -fsSL https://git.io/wallpaper-picker | bash

    # Custom wallpaper directory
    curl -fsSL https://git.io/wallpaper-picker | bash -s -- --dir ~/Pictures/Wallpapers

    # Enable audio
    curl -fsSL https://git.io/wallpaper-picker | bash -s -- --audio
EOF
}

check_requirements() {
    local missing=()
    
    for cmd in curl git; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        err "Missing required commands: ${missing[*]}"
        err "Install them with: sudo pacman -S ${missing[*]}"
        exit 1
    fi
}

install_dependencies() {
    info "Installing dependencies..."
    
    local packages=(mpv fzf jq libnotify)
    
    if ! command -v mpvpaper &>/dev/null; then
        packages+=(mpvpaper)
    fi
    
    for pkg in "${packages[@]}"; do
        if pacman -Q "$pkg" &>/dev/null || command -v "$pkg" &>/dev/null; then
            continue
        fi
        
        info "Installing $pkg..."
        if command -v yay &>/dev/null; then
            yay -S --noconfirm "$pkg" 2>/dev/null || sudo pacman -S --noconfirm "$pkg"
        elif command -v paru &>/dev/null; then
            paru -S --noconfirm "$pkg" 2>/dev/null || sudo pacman -S --noconfirm "$pkg"
        else
            sudo pacman -S --noconfirm "$pkg" 2>/dev/null || {
                warn "$pkg needs manual installation"
            }
        fi
    done
    
    ok "Dependencies installed"
}

download_files() {
    info "Downloading wallpaper-picker..."
    
    local temp_dir
    temp_dir=$(mktemp -d)
    trap "rm -rf '$temp_dir'" EXIT
    
    if ! git clone --depth 1 --branch "v${VERSION}" "https://github.com/${REPO}" "$temp_dir" 2>/dev/null; then
        err "Failed to download wallpaper-picker"
        exit 1
    fi
    
    mkdir -p "$BIN_DIR" "$CONFIG_DIR" "${HOME}/.local/share/applications" "${HOME}/.local/share/icons"
    
    install -Dm755 "$temp_dir/src/wallpaper-picker" "${BIN_DIR}/wallpaper-picker"
    install -Dm755 "$temp_dir/src/wallpaper-picker-gui" "${BIN_DIR}/wallpaper-picker-gui"
    install -Dm644 "$temp_dir/desktop/wallpaper-picker.desktop" "${HOME}/.local/share/applications/wallpaper-picker.desktop"
    install -Dm644 "$temp_dir/icons/wallpaper-picker.svg" "${HOME}/.local/share/icons/wallpaper-picker.svg"
    
    if [[ ! -f "${CONFIG_DIR}/config" ]]; then
        cat > "${CONFIG_DIR}/config" <<EOF
MONITOR=""
AUTO_DETECT_MONITOR="yes"
DEFAULT_WALLPAPER_DIR="${WALLPAPER_DIR}"
ENABLE_AUDIO="${ENABLE_AUDIO}"
LOOP_MODE="inf"
SLIDESHOW_INTERVAL=30
SLIDESHOW_SHUFFLE="no"
TIME_BASED_MODE="no"
SMART_RANDOM="yes"
RECENT_HISTORY_SIZE=10
PYWAL_ENABLED="no"
PYWAL_BACKEND="theme"
AUTO_RESTORE="yes"
AUTO_RELOAD="yes"
THUMBNAIL_ENABLED="yes"
CACHE_THUMBNAILS="yes"
NOTIFICATIONS_ENABLED="yes"
PREVIEW_ENABLED="yes"
PREVIEW_TIMEOUT=3
STARTUP_MODE="manual"
EOF
    fi
    
    ok "Files installed"
}

setup_path() {
    if [[ ":$PATH:" != *":${HOME}/.local/bin:"* ]]; then
        for rc in .bashrc .zshrc .profile; do
            if [[ -f "${HOME}/${rc}" ]]; then
                if ! grep -q '\.local/bin' "${HOME}/${rc}"; then
                    echo '' >> "${HOME}/${rc}"
                    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${HOME}/${rc}"
                fi
            fi
        done
        warn "Added ~/.local/bin to PATH. Restart your shell or run: source ~/.bashrc"
    fi
}

setup_autostart() {
    local autostart_dir="${HOME}/.config/autostart"
    mkdir -p "$autostart_dir"
    
    cat > "${autostart_dir}/wallpaper-picker.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Wallpaper Picker
Exec=wallpaper-picker restore
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF
    
    ok "Autostart configured"
}

print_success() {
    echo ""
    echo -e "${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║         Wallpaper Picker v${VERSION} Installed Successfully!        ║${NC}"
    echo -e "${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${GREEN}✓${NC} wallpaper-picker     - TUI interface"
    echo -e "  ${GREEN}✓${NC} wallpaper-picker-gui - GTK4 GUI"
    echo -e "  ${GREEN}✓${NC} App menu integration"
    echo ""
    echo -e "${BOLD}Quick Start:${NC}"
    echo -e "  ${CYAN}wallpaper-picker pick${NC}       - Interactive TUI picker"
    echo -e "  ${CYAN}wallpaper-picker gui${NC}        - GTK4 GUI picker"
    echo -e "  ${CYAN}wallpaper-picker random${NC}     - Random wallpaper"
    echo -e "  ${CYAN}wallpaper-picker help${NC}       - Full documentation"
    echo ""
    echo -e "${BOLD}Hyprland Keybindings:${NC}"
    echo -e '  bind = SUPER, W, exec, wallpaper-picker pick'
    echo ""
    echo -e "${BOLD}AUR:${NC} yay -S wallpaper-picker"
    echo ""
}

WALLPAPER_DIR="${HOME}/Videos/wallpapers"
ENABLE_AUDIO="no"

main() {
    echo ""
    echo -e "${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║              Wallpaper Picker Installer v${VERSION}                 ║${NC}"
    echo -e "${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    parse_args "$@"
    check_requirements
    install_dependencies
    download_files
    setup_path
    setup_autostart
    
    if [[ ! -d "${WALLPAPER_DIR}" ]]; then
        mkdir -p "${WALLPAPER_DIR}"
        info "Created wallpaper directory: ${WALLPAPER_DIR}"
    fi
    
    print_success
}

main "$@"
