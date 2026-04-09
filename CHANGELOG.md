# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2026-04-09

### Added
- **Smart Random**: New command `wallpaper-picker smart-random` that avoids recently used wallpapers
- **Time-Based Mode**: New command `wallpaper-picker time-based` for automatic wallpaper switching based on time of day
- **Video Preview**: Built-in video thumbnail generation using ffmpeg in TUI picker
- **ASCII Preview**: ASCII art preview for images (requires chafa or img2txt)
- **Enhanced FZF**: Ctrl+S for smart random, Ctrl+D for toggle favorite, Ctrl+P for preview

### Added (Configuration)
- `TIME_BASED_MODE`: Enable time-based wallpaper switching
- `TIME_BASED_FOLDERS`: Define time ranges for each mode (morning/afternoon/evening/night)
- `SMART_RANDOM`: Enable smart random mode
- `RECENT_HISTORY_SIZE`: How many recent wallpapers to avoid

## [2.0.0] - 2026-04-08

### Added
- **GTK4 GUI**: Full graphical interface with Adwaita styling
- **Preview Pane**: Shows video info, duration, resolution
- **Random Button**: Quick random wallpaper in GUI
- **Audio Toggle**: Enable/disable audio for video wallpapers
- **Multi-distro Support**: Debian, Fedora, Nix packages

### Added (Desktop Entry)
- Right-click menu actions: GUI, TUI, Random, Slideshow, Stop
- Better icon sizes (16, 32, 48, 64, 128, 256)

### Fixed
- `set -eo pipefail` causing early exit (now `set -o pipefail`)
- `cmd_picker` typo → `cmd_pick`
- fzf binding failing with spaces in paths
- WATCH_DIRS array expansion errors
- Undefined C_INFO variable

## [1.0.0] - 2026-04-08

### Added
- Initial release with TUI picker (fzf-based)
- Basic video wallpaper support via mpvpaper
- Favorites and history tracking
- Slideshow mode
- Multi-monitor support
- Desktop menu integration
- AUR package
