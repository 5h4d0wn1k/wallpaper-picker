# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.3.0] - 2026-04-09

### Added
- **Memory Leak Prevention**: mpvpaper is now automatically restarted after 4 hours or when memory exceeds 200MB to prevent the known mpvpaper memory leak issue (#101)
- **Black Flash Reduction**: Videos are preloaded before switching to minimize the black flash during wallpaper changes
- **Improved Auto-Restore**: Added delay and retry mechanism for more reliable wallpaper restoration on startup
- **File Validation**: Added proper read permission checks before setting wallpaper

### Added (Configuration)
- `MEMORY_LEAK_FIX`: Enable/disable periodic mpvpaper restart (default: yes)
- `MPV_RESTART_HOURS`: Hours before automatic restart (default: 4)
- `MPV_RESTART_MIN_MEM_MB`: Memory threshold in MB to trigger restart (default: 200)
- `PRELOAD_WALLPAPERS`: Enable video preloading (default: yes)
- `PRELOAD_DELAY`: Delay between kill and start (default: 0.5)
- `AUTO_RESTORE_DELAY`: Delay before restoring on startup (default: 3)
- `AUTO_RESTORE_RETRIES`: Number of restore attempts (default: 3)

### Fixed
- Wallpaper file permission validation
- Cleanup handler now properly stops mpv monitor thread

## [2.2.0] - 2026-04-09

### Added
- **Video Spanning**: Video wallpapers can now span across multiple monitors
- **Per-Monitor Preview**: GUI shows preview thumbnails for each monitor
- **Improved GUI**: Better GTK4 event handling and drag-and-drop monitor layout
- **Smart Random Action**: Added to desktop menu for quick access
- **Multi-Distro Packages**: Added Homebrew (macOS) and Nix flake

### Fixed
- Command argument parsing edge cases
- FZF interactive picker binding issues
- Temp file cleanup using proper trap
- GTK4 API compatibility (set_child, event controllers)

### Changed
- Improved install script with one-command installation
- Better desktop menu integration with locales

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
