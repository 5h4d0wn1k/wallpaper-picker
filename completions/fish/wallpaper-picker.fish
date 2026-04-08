# fish completion for wallpaper-picker

complete -c wallpaper-picker -f

# Commands
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'pick' -d 'Interactive wallpaper picker'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'browse' -d 'Browse and pick any video'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'random' -d 'Set random wallpaper'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'slideshow' -d 'Start slideshow mode'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'stop' -d 'Stop current wallpaper'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'current' -d 'Show current wallpaper'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'next' -d 'Next wallpaper'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'prev' -d 'Previous wallpaper'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'list' -d 'List all wallpapers'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'add-dir' -d 'Add watch directory'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'remove-dir' -d 'Remove watch directory'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'watch-dirs' -d 'List watch directories'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'toggle-fav' -d 'Toggle favorite status'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'toggle-favorite' -d 'Toggle favorite status'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'config' -d 'Edit configuration'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'monitors' -d 'List available monitors'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'clear-cache' -d 'Clear thumbnail cache'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'status' -d 'Show detailed status'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'doctor' -d 'Check dependencies'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'enable-startup' -d 'Enable on login'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'disable-startup' -d 'Disable on login'
complete -c wallpaper-picker -n '__fish_use_subcommand' -a 'help' -d 'Show help'

# Options
complete -c wallpaper-picker -s h -l help -d 'Show help'
complete -c wallpaper-picker -s v -l version -d 'Show version'
complete -c wallpaper-picker -s m -l monitor -d 'Target monitor' -r
complete -c wallpaper-picker -s d -l dir -d 'Wallpaper directory' -r
complete -c wallpaper-picker -s n -l no-notify -d 'Disable notifications'

# Filetype completions
complete -c wallpaper-picker -n '__fish_seen_subcommand_from toggle-fav toggle-favorite' -a '(string replace -r -- "(.+)\.(mp4|webm|mkv|avi|mov)$" "\1")' -g '*.mp4' -g '*.webm' -g '*.mkv' -g '*.avi' -g '*.mov'
