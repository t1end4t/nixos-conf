{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # daemon
      exec-once = [
        "fcitx5"
        "systemctl --user start kanshi.service"

        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.mako}/bin/mako --default-timeout 5000"
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store" # Stores only image data
        "${pkgs.swayest-workstyle}/bin/sworkstyle" # better workspace
        "${pkgs.hypridle}/bin/hypridle"
      ];

      # gaps
      general = {
        gaps_in = 2;
        gaps_out = 2;

      };

      # General idle behavior
      general = {
      };

      # cursor
      cursor = {
        hide_on_key_press = true;
        inactive_timeout = 3;
      };

      # keybindings
      bind = import "${ROOT}/keybindings.nix" { inherit pkgs; };
    };
  };
}
