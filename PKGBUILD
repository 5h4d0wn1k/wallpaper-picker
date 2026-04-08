# Maintainer: shadowarch <https://github.com/5h4d0wn1k>
# Contributor: shadowarch <https://github.com/5h4d0wn1k>

pkgname=wallpaper-picker
pkgver=2.0.0
pkgrel=1
pkgdesc="A sleek, feature-rich video wallpaper manager for Arch Linux/Hyprland"
arch=('any')
url="https://github.com/5h4d0wn1k/wallpaper-picker"
license=('MIT')
depends=(
    'bash'
    'mpvpaper'
    'fzf'
    'mpv'
    'jq'
)
optdepends=(
    'gtk4: For GUI support'
    'python-gobject: For GUI support'
    'ffmpeg: For video thumbnails and metadata'
    'libnotify: Desktop notifications'
    'systemd: For startup service'
)
provides=('wallpaper-picker')
conflicts=('wallpaper-picker-git')
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$srcdir/$pkgname-$pkgver"
    
    # Install main scripts
    install -Dm755 src/wallpaper-picker "$pkgdir/usr/bin/wallpaper-picker"
    install -Dm755 src/wallpaper-picker-gui "$pkgdir/usr/bin/wallpaper-picker-gui"
    
    # Install desktop entry (menu integration)
    install -Dm644 desktop/wallpaper-picker.desktop \
        "$pkgdir/usr/share/applications/wallpaper-picker.desktop"
    
    # Install icon
    install -Dm644 icons/wallpaper-picker.svg \
        "$pkgdir/usr/share/icons/hicolor/128x128/apps/wallpaper-picker.svg"
    install -Dm644 icons/wallpaper-picker.svg \
        "$pkgdir/usr/share/pixmaps/wallpaper-picker.svg"
    
    # Install man page
    install -Dm644 wallpaper-picker.1 \
        "$pkgdir/usr/share/man/man1/wallpaper-picker.1.gz"
    
    # Install shell completions
    install -Dm644 completions/bash/wallpaper-picker \
        "$pkgdir/usr/share/bash-completion/completions/wallpaper-picker"
    install -Dm644 completions/zsh/_wallpaper-picker \
        "$pkgdir/usr/share/zsh/site-functions/_wallpaper-picker"
    install -Dm644 completions/fish/wallpaper-picker.fish \
        "$pkgdir/usr/share/fish/vendor_completions.d/wallpaper-picker.fish"
    
    # Install systemd service
    install -Dm644 systemd/wallpaper-picker.service \
        "$pkgdir/usr/lib/systemd/user/wallpaper-picker.service"
    
    # Install documentation
    install -Dm644 README.md \
        "$pkgdir/usr/share/doc/$pkgname/README.md"
    install -Dm644 LICENSE \
        "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}

post_install() {
    # Update desktop database
    update-desktop-database "$pkgdir/usr/share/applications/" 2>/dev/null || true
    update-icon-cache "$pkgdir/usr/share/icons/" 2>/dev/null || true
    
    echo ""
    echo -e "\033[1;36m╔══════════════════════════════════════════════════╗\033[0m"
    echo -e "\033[1;36m║        Wallpaper Picker v${pkgver} Installed           ║\033[0m"
    echo -e "\033[1;36m╚══════════════════════════════════════════════════╝\033[0m"
    echo ""
    echo "  • Run 'wallpaper-picker --help' for usage"
    echo "  • Run 'wallpaper-picker doctor' to check dependencies"
    echo "  • Launch from application menu: Wallpaper Picker"
    echo ""
}

post_upgrade() {
    post_install
}
