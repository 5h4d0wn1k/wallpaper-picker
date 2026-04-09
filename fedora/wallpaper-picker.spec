%global gitexpand 5h4d0wn1k

Name:           wallpaper-picker
Version:        2.2.0
Release:        1%{?dist}
Summary:        A sleek video wallpaper manager for Hyprland/Wayland

License:        MIT
URL:            https://github.com/%{gitexpand}/wallpaper-picker
Source0:        https://github.com/%{gitexpand}/wallpaper-picker/archive/refs/tags/v%{version}.tar.gz

BuildArch:      noarch

Requires:       bash >= 4.0
Requires:       fzf
Requires:       mpv
Requires:       jq
Requires:       xwallpaper
Suggests:       ffmpeg
Suggests:       libnotify

%description
A sleek, feature-rich video wallpaper manager designed specifically for
Hyprland and Wayland compositors.

Features include:
* Interactive TUI picker using fzf
* GTK4 GUI with thumbnails
* Random and slideshow modes
* Multi-monitor support
* Favorites and history tracking
* PyWal colorscheme integration
* Time-based wallpaper switching

%prep
%autosetup -p1

%build

%install
install -Dm755 src/wallpaper-picker %{buildroot}%{_bindir}/wallpaper-picker
install -Dm755 src/wallpaper-picker-gui %{buildroot}%{_bindir}/wallpaper-picker-gui
install -Dm644 desktop/wallpaper-picker.desktop %{buildroot}%{_datadir}/applications/%{name}.desktop
install -Dm644 icons/wallpaper-picker.svg %{buildroot}%{_datadir}/icons/hicolor/scalable/apps/%{name}.svg
install -Dm644 icons/wallpaper-picker.svg %{buildroot}%{_datadir}/pixmaps/%{name}.svg
install -Dm644 completions/bash/wallpaper-picker %{buildroot}%{_bash_completion}/completions/%{name}
install -Dm644 completions/zsh/_wallpaper-picker %{buildroot}%{_datarootdir}/zsh/site-functions/_%{name}
install -Dm644 completions/fish/wallpaper-picker.fish %{buildroot}%{_datadir}/fish/vendor_completions.d/%{name}.fish
install -Dm644 README.md %{buildroot}%{_docdir}/%{name}/README.md
install -Dm644 CHANGELOG.md %{buildroot}%{_docdir}/%{name}/CHANGELOG.md
install -Dm644 LICENSE %{buildroot}%{_docdir}/%{name}/LICENSE

%files
%{_bindir}/wallpaper-picker
%{_bindir}/wallpaper-picker-gui
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/scalable/apps/%{name}.svg
%{_datadir}/pixmaps/%{name}.svg
%{_bash_completion}/completions/%{name}
%{_datarootdir}/zsh/site-functions/_%{name}
%{_datadir}/fish/vendor_completions.d/%{name}.fish
%{_docdir}/%{name}/README.md
%{_docdir}/%{name}/CHANGELOG.md
%{_docdir}/%{name}/LICENSE

%changelog
* Thu Apr 09 2026 5h4d0wn1k <https://github.com/5h4d0wn1k>
- Release v2.2.0 - Video spanning, per-monitor preview, GUI fixes

* Wed Apr 08 2026 5h4d0wn1k <https://github.com/5h4d0wn1k>
- Release v2.1.0 - Smart random, time-based, PyWal integration

* Tue Apr 07 2026 5h4d0wn1k <https://github.com/5h4d0wn1k>
- Initial release v2.0.0
