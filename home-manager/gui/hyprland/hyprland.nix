{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  imports = [
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # daemon
      exec-once = [
        "waybar"
        "hyprpaper"
      ];

      # gaps
      general = {
        gaps_in = 2;
        gaps_out = 2;
      };

      # keybindings
      bind = import "${ROOT}/keybindings.nix" { inherit pkgs; };
    };

    # extraConfig = builtins.readFile "${ROOT}/extraConfig.nix";
  };
}
