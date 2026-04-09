# 🎨 Wallpaper Picker

<p align="center">
  <a href="https://github.com/5h4d0wn1k/wallpaper-picker/releases/latest">
    <img src="https://img.shields.io/github/v/release/5h4d0wn1k/wallpaper-picker?style=flat-square" alt="Version">
  </a>
  <a href="https://github.com/5h4d0wn1k/wallpaper-picker/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/5h4d0wn1k/wallpaper-picker?style=flat-square" alt="License">
  </a>
  <a href="https://github.com/5h4d0wn1k/wallpaper-picker/actions/workflows/tests.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/5h4d0wn1k/wallpaper-picker/tests.yml?style=flat-square" alt="Tests">
  </a>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/icons/wallpaper-picker.svg" width="128" alt="Icon">
</p>

---

> A **sleek, feature-rich** video wallpaper manager designed specifically for **Arch Linux** and **Hyprland**.

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Interactive TUI** | Beautiful fzf-based picker with video preview |
| 🖥️ **GTK4 GUI** | Full graphical interface with thumbnails |
| 📺 **Multi-Monitor** | Full support for multiple displays with auto-detection |
| 🎬 **Video Spanning** | Video wallpapers across multiple monitors |
| ⏸️ **Pause/Resume** | Pause and resume wallpaper playback |
| 🔋 **Battery-Aware** | Automatic quality adjustment on battery |
| 🌐 **Wallhaven Search** | Search and download wallpapers from Wallhaven |
| 🔀 **Multiple Backends** | mpvpaper, swww, hyprpaper, swaybg support |
| ⭐ **Favorites** | Mark and quickly access your favorite wallpapers |
| 🕐 **Time-Based** | Automatic wallpaper based on time of day |
| 🎲 **Smart Random** | Avoid recently used wallpapers |
| 📜 **History** | Track your wallpaper usage over time |
| 🖼️ **Thumbnails** | Fast thumbnail caching for instant browsing |
| 🔔 **Notifications** | Desktop notifications when changing wallpapers |
| ⚙️ **Configurable** | Fully customizable via config file |
| 🔧 **Doctor Mode** | Diagnose and fix common issues automatically |
| 🚀 **Auto-Start** | Systemd integration for startup slideshow |
| 📱 **Menu Integration** | Appears in application menus with quick actions |

---

## 🚀 Quick Installation

### One-Line Install (Recommended)

```bash
curl -fsSL https://git.io/wallpaper-picker | bash
```

### AUR (yay/paru)

```bash
# Using yay
yay -S wallpaper-picker

# Using paru
paru -S wallpaper-picker
```

### Manual Installation

```bash
# Download the scripts
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker -o ~/.local/bin/wallpaper-picker
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker-gui -o ~/.local/bin/wallpaper-picker-gui
chmod +x ~/.local/bin/wallpaper-picker ~/.local/bin/wallpaper-picker-gui

# Install desktop entry for menu
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/desktop/wallpaper-picker.desktop -o ~/.local/share/applications/wallpaper-picker.desktop
```

---

## 🔧 Requirements

### Required Dependencies

| Package | AUR/Repo | Description |
|---------|-----------|-------------|
| `mpvpaper` | [AUR](https://aur.archlinux.org/packages/mpvpaper) | Video wallpaper for wlroots |
| `fzf` | [Extra](https://archlinux.org/packages/extra/x86_64/fzf/) | Fuzzy finder |
| `mpv` | [Extra](https://archlinux.org/packages/extra/x86_64/mpv/) | Media player |
| `jq` | [Extra](https://archlinux.org/packages/extra/x86_64/jq/) | JSON processing |

### Optional Dependencies

| Package | AUR/Repo | Description |
|---------|-----------|-------------|
| `gtk4` | [Extra](https://archlinux.org/packages/extra/x86_64/gtk4/) | GUI support |
| `python-gobject` | [Extra](https://archlinux.org/packages/extra/x86_64/python-gobject/) | GUI support |
| `ffmpeg` | [Extra](https://archlinux.org/packages/extra/x86_64/ffmpeg/) | Thumbnails & metadata |
| `libnotify` | [Extra](https://archlinux.org/packages/extra/x86_64/libnotify/) | Notifications |

### Install All Dependencies

```bash
# For AUR packages (mpvpaper)
yay -S mpvpaper

# For repo packages
sudo pacman -S fzf mpv jq ffmpeg libnotify gtk4 python-gobject
```

---

## 📖 Usage

### Interactive Commands

| Command | Description |
|---------|-------------|
| `wallpaper-picker pick` | Interactive TUI picker (fzf) |
| `wallpaper-picker gui` | GTK4 GUI picker |
| `wallpaper-picker browse` | Browse any video file |
| `wallpaper-picker random` | Set random wallpaper |
| `wallpaper-picker smart-random` | Random (avoids recent) |
| `wallpaper-picker time-based` | Wallpaper based on time of day |
| `wallpaper-picker slideshow 60` | Slideshow mode (60s) |

### Playback Control

| Command | Description |
|---------|-------------|
| `wallpaper-picker stop` | Stop current wallpaper |
| `wallpaper-picker pause` | Pause wallpaper |
| `wallpaper-picker resume` | Resume wallpaper |
| `wallpaper-picker toggle` | Toggle pause/resume |

### Navigation Commands

| Command | Description |
|---------|-------------|
| `wallpaper-picker current` | Show current wallpaper |
| `wallpaper-picker next` | Next wallpaper |
| `wallpaper-picker prev` | Previous wallpaper |
| `wallpaper-picker list` | List all wallpapers |

### Management Commands

| Command | Description |
|---------|-------------|
| `wallpaper-picker add-dir <path>` | Add watch directory |
| `wallpaper-picker remove-dir <path>` | Remove directory |
| `wallpaper-picker watch-dirs` | List watch directories |
| `wallpaper-picker toggle-fav` | Toggle favorite |
| `wallpaper-picker wallhaven <query>` | Search Wallhaven |

### System Commands

| Command | Description |
|---------|-------------|
| `wallpaper-picker status` | Show detailed status |
| `wallpaper-picker doctor` | Diagnose issues |
| `wallpaper-picker monitors` | List monitors |
| `wallpaper-picker backend [name]` | Set/query wallpaper backend |
| `wallpaper-picker quality` | Show quality profile |
| `wallpaper-picker enable-startup` | Enable on login |
| `wallpaper-picker disable-startup` | Disable on login |

---

## 🖥️ Application Menu

The app integrates with your desktop environment.

### Launcher Actions
Right-click the app icon to see quick actions:
- **Open GUI** - Launch graphical interface
- **Open TUI** - Launch terminal picker
- **Random Wallpaper** - Set random wallpaper
- **Start Slideshow** - Begin slideshow mode

### Keyboard Shortcuts (Hyprland)

Add to `~/.config/hypr/hyprland.conf`:

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
├── watch-dirs     # Additional directories
└── thumbnails/    # Cached thumbnails

~/.cache/wallpaper-picker/
├── state.json     # Current state
└── wallpaper-picker.log  # Logs

~/.local/share/wallpaper-picker/
├── history        # Usage history
└── favorites     # Favorited wallpapers
```

---

## 🔍 Troubleshooting

### Doctor Mode

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
│   ├── wallpaper-picker          # Main TUI script (Bash)
│   └── wallpaper-picker-gui      # GUI script (Python/GTK4)
├── desktop/
│   └── wallpaper-picker.desktop  # Desktop entry
├── icons/
│   └── wallpaper-picker.svg      # App icon
├── tests/
│   └── run_tests.sh             # Test suite
├── .github/
│   ├── workflows/              # CI/CD
│   └── ISSUE_TEMPLATE/        # Templates
├── PKGBUILD                     # AUR package
├── install.sh                   # Quick installer
├── README.md
├── LICENSE
└── CONTRIBUTING.md
```

### Running Tests

```bash
./tests/run_tests.sh
```

---

## 📜 License

MIT License - see [LICENSE](LICENSE)

---

## 🙏 Acknowledgments

- [mpvpaper](https://github.com/GhostNaN/mpvpaper) - Video wallpaper for wlroots
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [Hyprland](https://hyprland.org/) - Wayland compositor

---

<p align="center">
  Made with ❤️ for the Arch Linux rice community
</p>
