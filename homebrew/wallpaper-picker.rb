class WallpaperPicker < Formula
  desc "A sleek, feature-rich video wallpaper manager for Hyprland/Wayland"
  homepage "https://github.com/5h4d0wn1k/wallpaper-picker"
  url "https://github.com/5h4d0wn1k/wallpaper-picker/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  version "2.2.0"

  depends_on "fzf"
  depends_on "mpv"
  depends_on "jq"

  def install
    bin.install "src/wallpaper-picker" => "wallpaper-picker"
    bin.install "src/wallpaper-picker-gui" => "wallpaper-picker-gui"
    bash_completion.install "completions/bash/wallpaper-picker"
    zsh_completion.install "completions/zsh/_wallpaper-picker"
    fish_completion.install "completions/fish/wallpaper-picker.fish"
    etc.install "desktop/wallpaper-picker.desktop" => "wallpaper-picker.desktop"
    share.install "icons/wallpaper-picker.svg" => "wallpaper-picker.svg"
  end

  def caveats
    <<~EOS
      Wallpaper Picker is designed for Hyprland/Wayland.
      
      On macOS, you can use it with xwallpaper or similar tools.
      
      For wallpaper management on macOS, consider using:
        - wallp
        - paper
        - plasmate
      
      Installation locations:
        - Binaries: #{bin}
        - Desktop entry: #{etc}/wallpaper-picker.desktop
        - Icon: #{share}/wallpaper-picker.svg
    EOS
  end

  test do
    system "#{bin}/wallpaper-picker", "--version"
  end
end
