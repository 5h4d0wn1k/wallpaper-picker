name: wallpaper-picker
description: A sleek video wallpaper manager for Hyprland/Wayland
version: 2.0.0
release: 1
license: MIT
summary: Video wallpaper manager for Hyprland
url: https://github.com/5h4d0wn1k/wallpaper-picker
packager: 5h4d0wn1k

requires:
    bash >= 4.0
    mpvpaper
    fzf
    mpv
    jq

buildrequires:

sources:
    https://github.com/5h4d0wn1k/wallpaper-picker/releases/download/v%{version}/wallpaper-picker-%{version}.tar.gz

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/applications
mkdir -p %{buildroot}%{_datadir}/icons/hicolor/128x128/apps

install -m 755 src/wallpaper-picker %{buildroot}%{_bindir}/
install -m 755 src/wallpaper-picker-gui %{buildroot}%{_bindir}/
install -m 644 desktop/wallpaper-picker.desktop %{buildroot}%{_datadir}/applications/
install -m 644 icons/128x128.png %{buildroot}%{_datadir}/icons/hicolor/128x128/apps/

%files
%{_bindir}/wallpaper-picker
%{_bindir}/wallpaper-picker-gui
%{_datadir}/applications/wallpaper-picker.desktop
%{_datadir}/icons/hicolor/128x128/apps/wallpaper-picker.png
