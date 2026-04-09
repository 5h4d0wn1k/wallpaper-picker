{
  "description": "A sleek video wallpaper manager for Hyprland/Wayland",
  "name": "wallpaper-picker",
  "version": "2.0.0",
  "inputs": {
    "mpvpaper": {
      "type": "package",
      "pkgpath": "."
    }
  },
  "outputs": [
    "out"
  ],
  "buildInputs": [
    "bash",
    "fzf",
    "mpv",
    "jq"
  ],
  "optionalBuildInputs": [
    "gtk4",
    "python3GObject",
    "ffmpeg",
    "libnotify"
  ],
  "installPhase": ''
    #!/usr/bin/env bash
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/128x128/apps
    
    cp src/wallpaper-picker $out/bin/
    cp src/wallpaper-picker-gui $out/bin/
    chmod +x $out/bin/wallpaper-picker $out/bin/wallpaper-picker-gui
    
    cp desktop/wallpaper-picker.desktop $out/share/applications/
    cp icons/128x128.png $out/share/icons/hicolor/128x128/apps/wallpaper-picker.png
  '',
  "shell": "/usr/bin/env bash"
}
