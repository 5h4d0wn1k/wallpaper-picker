# Wallpaper Picker - Quick Reference

## Installation

### Arch Linux (One-liner)
```bash
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/install.sh | bash
```

### Arch Linux (AUR)
```bash
yay -S wallpaper-picker
# or
paru -S wallpaper-picker
```

### Manual Install
```bash
# TUI
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker -o ~/.local/bin/wallpaper-picker
chmod +x ~/.local/bin/wallpaper-picker

# GUI
curl -fsSL https://raw.githubusercontent.com/5h4d0wn1k/wallpaper-picker/main/src/wallpaper-picker-gui -o ~/.local/bin/wallpaper-picker-gui
chmod +x ~/.local/bin/wallpaper-picker-gui
```

## Quick Commands

| Command | Description |
|---------|-------------|
| `wallpaper-picker pick` | Interactive TUI picker |
| `wallpaper-picker gui` | GTK4 GUI picker |
| `wallpaper-picker random` | Random wallpaper |
| `wallpaper-picker smart-random` | Random (avoids recent) |
| `wallpaper-picker slideshow` | Slideshow mode |
| `wallpaper-picker stop` | Stop wallpaper |

## Keybindings (Hyprland)

Add to `~/.config/hypr/hyprland.conf`:
```bash
bind = SUPER, W, exec, wallpaper-picker pick
bind = SUPER SHIFT, W, exec, wallpaper-picker gui
bind = SUPER CTRL, W, exec, wallpaper-picker random
bind = SUPER ALT, W, exec, wallpaper-picker stop
```

## Features

- Interactive TUI with fzf
- GTK4 GUI with thumbnails
- Multi-monitor support
- Video wallpaper spanning
- Smart random (avoids recent)
- Time-based wallpaper
- PyWal integration
- Slideshow mode
- Favorites & history
- Desktop menu integration

## Troubleshooting

```bash
# Check status
wallpaper-picker doctor

# List monitors
wallpaper-picker monitors

# Restore last wallpaper
wallpaper-picker restore

# Set specific monitor
wallpaper-picker set-monitor HDMI-A-1 video.mp4
```

## Links

- GitHub: https://github.com/5h4d0wn1k/wallpaper-picker
- AUR: https://aur.archlinux.org/packages/wallpaper-picker
- Issues: https://github.com/5h4d0wn1k/wallpaper-picker/issues
