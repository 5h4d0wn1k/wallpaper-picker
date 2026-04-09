{
  description = "A sleek video wallpaper manager for Hyprland/Wayland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.wallpaper-picker = pkgs.stdenv.mkDerivation {
          pname = "wallpaper-picker";
          version = "2.2.0";

          src = pkgs.fetchFromGitHub {
            owner = "5h4d0wn1k";
            repo = "wallpaper-picker";
            rev = "v2.2.0";
            sha256 = "0000000000000000000000000000000000000000000000000000000000000000";
          };

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/bin
            cp src/wallpaper-picker $out/bin/
            cp src/wallpaper-picker-gui $out/bin/
            chmod +x $out/bin/wallpaper-picker
            chmod +x $out/bin/wallpaper-picker-gui

            mkdir -p $out/share/applications
            cp desktop/wallpaper-picker.desktop $out/share/applications/

            mkdir -p $out/share/icons/hicolor/scalable/apps
            cp icons/wallpaper-picker.svg $out/share/icons/hicolor/scalable/apps/

            mkdir -p $out/share/bash-completion/completions
            cp completions/bash/wallpaper-picker $out/share/bash-completion/completions/

            mkdir -p $out/share/zsh/site-functions
            cp completions/zsh/_wallpaper-picker $out/share/zsh/site-functions/

            mkdir -p $out/share/fish/vendor_completions.d
            cp completions/fish/wallpaper-picker.fish $out/share/fish/vendor_completions.d/
          '';

          runtimeDeps = with pkgs; [
            bash
            fzf
            mpv
            jq
            mpvpaper
            ffmpeg
            libnotify
          ];

          meta = with pkgs.lib; {
            description = "Video wallpaper manager for Hyprland/Wayland";
            homepage = "https://github.com/5h4d0wn1k/wallpaper-picker";
            license = licenses.mit;
            maintainers = [ maintainers.5h4d0wn1k ];
            platforms = platforms.linux;
          };
        };

        defaultPackage = self.packages.${system}.wallpaper-picker;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bash
            fzf
            mpv
            jq
          ];
        };
      }
    );
}
