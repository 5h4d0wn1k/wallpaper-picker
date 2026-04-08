<p align="center">
  <img src="https://raw.githubusercontent.com/shadowarch/wallpaper-picker/main/.github/banner.png" alt="wallpaper-picker" width="600"/>
</p>

<p align="center">
  <a href="https://github.com/shadowarch/wallpaper-picker/releases/latest">
    <img src="https://img.shields.io/github/v/release/shadowarch/wallpaper-picker?style=flat-square" alt="Version">
  </a>
  <a href="https://github.com/shadowarch/wallpaper-picker/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/shadowarch/wallpaper-picker?style=flat-square" alt="License">
  </a>
  <a href="https://github.com/shadowarch/wallpaper-picker/actions/workflows/tests.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/shadowarch/wallpaper-picker/tests.yml?style=flat-square" alt="Tests">
  </a>
  <img src="https://img.shields.io/badge/Arch%20Linux-ready-brightgreen?style=flat-square" alt="Arch">
</p>

---

> **A sleek, feature-rich video wallpaper manager for Arch Linux and Hyprland.**

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Interactive TUI** | Beautiful fzf-based picker with video preview |
| 🖥️ **GTK4 GUI** | Full graphical interface with thumbnails |
| 🔄 **Multiple Modes** | Manual, random, slideshow, and sequential playback |
| 📺 **Multi-Monitor** | Full support for multiple displays with auto-detection |
| ⭐ **Favorites** | Mark and quickly access your favorite wallpapers |
| 📜 **History** | Track your wallpaper usage over time |
| 🖼️ **Thumbnails** | Fast thumbnail caching for instant browsing |
| 🔔 **Notifications** | Desktop notifications when changing wallpapers |
| ⚙️ **Configurable** | Fully customizable via config file |
| 🔧 **Doctor Mode** | Diagnose and fix common issues automatically |
| 🚀 **Auto-Start** | Systemd integration for startup slideshow |

---

## 📦 Installation

### Option 1: AUR (Recommended)

```bash
# Using yay
yay -S wallpaper-picker

# Using paru
paru -S wallpaper-picker
```

### Option 2: Manual Installation

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/shadowarch/wallpaper-picker/main/wallpaper-picker -o ~/.local/bin/wallpaper-picker
chmod +x ~/.local/bin/wallpaper-picker

# For GUI support (optional)
curl -fsSL https://raw.githubusercontent.com/shadowarch/wallpaper-picker/main/wallpaper-picker-gui -o ~/.local/bin/wallpaper-picker-gui
chmod +x ~/.local/bin/wallpaper-picker-gui
```

### Option 3: Build from Source

```bash
git clone https://github.com/shadowarch/wallpaper-picker.git
cd wallpaper-picker
./install.sh
```

---

## 🔧 Requirements

### Required Dependencies

| Package | Source | Description |
|---------|--------|-------------|
| `mpvpaper` | [AUR](https://aur.archlinux.org/packages/mpvpaper) | Video wallpaper for wlroots |
| `fzf` | [Extra](https://archlinux.org/packages/extra/x86_64/fzf/) | Fuzzy finder (TUI) |
| `mpv` | [Extra](https://archlinux.org/packages/extra/x86_64/mpv/) | Media player |

### Optional Dependencies

| Package | Source | Description |
|---------|--------|-------------|
| `python-gobject` + `gtk4` | [Extra](https://archlinux.org/packages/extra/x86_64/gtk4/) | GUI support |
| `ffmpeg` | [Extra](https://archlinux.org/packages/extra/x86_64/ffmpeg/) | Thumbnails & metadata |
| `libnotify` | [Extra](https://archlinux.org/packages/extra/x86_64/libnotify/) | Notifications |

### Quick Install All Dependencies

```bash
sudo pacman -S fzf mpv jq ffmpeg libnotify
yay -S mpvpaper
```

---

## 🚀 Usage

### TUI Commands

```bash
wallpaper-picker pick              # Interactive picker (fzf)
wallpaper-picker browse            # Browse any video file
wallpaper-picker random            # Set random wallpaper
wallpaper-picker slideshow 60     # Start slideshow (60s interval)
```

### GUI

```bash
wallpaper-picker gui               # Launch GTK4 GUI
```

### Navigation Commands

```bash
wallpaper-picker current           # Show current wallpaper
wallpaper-picker next              # Next wallpaper
wallpaper-picker prev              # Previous wallpaper
wallpaper-picker list              # List all wallpapers
```

### Management Commands

```bash
wallpaper-picker add-dir ~/Downloads/wallpapers    # Add watch directory
wallpaper-picker remove-dir ~/Downloads/wallpapers # Remove directory
wallpaper-picker watch-dirs                         # List watch directories
wallpaper-picker toggle-fav                         # Toggle favorite
```

### System Commands

```bash
wallpaper-picker status            # Show detailed status
wallpaper-picker doctor            # Diagnose issues
wallpaper-picker monitors         # List available monitors
wallpaper-picker enable-startup    # Enable on login
wallpaper-picker disable-startup  # Disable on login
```

---

## ⌨️ Hyprland Integration

Add these keybindings to `~/.config/hypr/hyprland.conf`:

```bash
# Interactive TUI picker
bind = SUPER, W, exec, wallpaper-picker pick

# GUI picker
bind = SUPER SHIFT, W, exec, wallpaper-picker gui

# Random wallpaper
bind = SUPER CTRL, W, exec, wallpaper-picker random

# Stop wallpaper
bind = SUPER ALT, W, exec, wallpaper-picker stop

# Slideshow mode
bind = SUPER, Grave, exec, wallpaper-picker slideshow
```

---

## ⚙️ Configuration

Edit `~/.config/wallpaper-picker/config`:

```bash
# Monitor Configuration
MONITOR=""                        # Leave empty for auto-detect
AUTO_DETECT_MONITOR="yes"

# Directory Configuration
DEFAULT_WALLPAPER_DIR="$HOME/Videos/wallpapers"

# Playback Configuration
ENABLE_AUDIO="no"
LOOP_MODE="inf"

# Slideshow Configuration
SLIDESHOW_INTERVAL=30
SLIDESHOW_SHUFFLE="no"

# UI Configuration
THUMBNAIL_ENABLED="yes"
CACHE_THUMBNAILS="yes"
NOTIFICATIONS_ENABLED="yes"
PREVIEW_ENABLED="yes"
PREVIEW_TIMEOUT=3
```

---

## 📁 File Structure

```
~/.config/wallpaper-picker/
├── config          # Main configuration
├── watch-dirs      # Additional directories to watch
└── thumbnails/     # Cached video thumbnails

~/.cache/wallpaper-picker/
├── state.json      # Current wallpaper state
└── wallpaper-picker.log  # Application log

~/.local/share/wallpaper-picker/
├── history         # Wallpaper usage history
└── favorites      # Favorited wallpapers
```

---

## 🧪 Testing

```bash
./tests/run_tests.sh
```

---

## 🔍 Troubleshooting

### Doctor Mode

Run the built-in diagnostic:

```bash
wallpaper-picker doctor
```

### Common Issues

**No videos found**
```bash
wallpaper-picker add-dir ~/Downloads/wallpapers
```

**Wrong monitor**
```bash
wallpaper-picker monitors
wallpaper-picker -m HDMI-A-1 pick
```

**Wallpaper not showing**
```bash
wallpaper-picker stop
wallpaper-picker pick
```

---

## 🏗️ Development

### Project Structure

```
wallpaper-picker/
├── src/
│   ├── wallpaper-picker          # Main TUI script
│   └── wallpaper-picker-gui     # GUI script (Python/GTK4)
├── tests/
│   └── run_tests.sh              # Test suite
├── .github/
│   ├── workflows/               # GitHub Actions
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   └── PULL_REQUEST_TEMPLATE.md # PR template
├── PKGBUILD                      # AUR package
├── README.md
├── LICENSE
└── CONTRIBUTING.md
```

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [mpvpaper](https://github.com/GhostNaN/mpvpaper) - Video wallpaper for wlroots
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [Hyprland](https://hyprland.org/) - Wayland compositor
- [Arch Linux](https://archlinux.org/) - Linux distribution

---

<p align="center">
  Made with ❤️ for the Arch Linux rice community
</p>
