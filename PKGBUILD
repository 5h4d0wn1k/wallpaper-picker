# Maintainer: shadowarch <your@email.com>
# Contributor: shadowarch <your@email.com>

pkgname=wallpaper-picker
pkgver=1.0.0
pkgrel=1
pkgdesc="A sleek, feature-rich video wallpaper manager for Arch Linux/Hyprland"
arch=('any')
url="https://github.com/shadowarch/wallpaper-picker"
license=('MIT')
depends=(
    'bash'
    'mpvpaper'           # Video wallpaper for wlroots
    'fzf'                # Fuzzy finder
    'mpv'                # Media player
    'jq'                 # JSON processing
    'hyprland'           # Wayland compositor (optional for detection)
)
makedepends=(
    'git'
)
optdepends=(
    'ffmpeg: For video thumbnails and metadata'
    'libnotify: Desktop notifications'
    'systemd: For startup service'
)
provides=('wallpaper-picker')
conflicts=('wallpaper-picker-git')
source=("$pkgname-$pkgver.tar.gz::https://github.com/shadowarch/wallpaper-picker/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$srcdir/$pkgname-$pkgver"
    
    # Install main script
    install -Dm755 wallpaper-picker "$pkgdir/usr/bin/wallpaper-picker"
    
    # Install man page
    install -Dm644 wallpaper-picker.1.gz "$pkgdir/usr/share/man/man1/wallpaper-picker.1.gz"
    
    # Install shell completions
    install -Dm644 completions/bash/wallpaper-picker \
        "$pkgdir/usr/share/bash-completion/completions/wallpaper-picker"
    install -Dm644 completions/zsh/_wallpaper-picker \
        "$pkgdir/usr/share/zsh/site-functions/_wallpaper-picker"
    install -Dm644 completions/fish/wallpaper-picker.fish \
        "$pkgdir/usr/share/fish/vendor_completions.d/wallpaper-picker.fish"
    
    # Install configuration directory skeleton
    install -dm755 "$pkgdir/etc/skel/.config/wallpaper-picker"
    install -Dm644 config/config.example \
        "$pkgdir/usr/share/doc/$pkgname/config.example"
    
    # Install systemd user service
    install -Dm644 systemd/wallpaper-picker.service \
        "$pkgdir/usr/lib/systemd/user/wallpaper-picker.service"
}

# Post-install hook
post_install() {
    # Create user configuration directory
    if [[ ! -d "$HOME/.config/wallpaper-picker" ]]; then
        mkdir -p "$HOME/.config/wallpaper-picker"
        cp /usr/share/doc/wallpaper-picker/config.example \
           "$HOME/.config/wallpaper-picker/config" 2>/dev/null || true
    fi
    
    echo ""
    echo -e "\033[1;36mWallpaper Picker installed successfully!\033[0m"
    echo ""
    echo "Configuration: ~/.config/wallpaper-picker/config"
    echo ""
    echo "Run 'wallpaper-picker doctor' to check dependencies"
    echo "Run 'wallpaper-picker help' for usage"
    echo ""
}

# Upgrade hook
post_upgrade() {
    echo ""
    echo -e "\033[1;36mWallpaper Picker updated to v$pkgver\033[0m"
    echo ""
}
