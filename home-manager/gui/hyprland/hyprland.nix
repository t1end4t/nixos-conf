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
        "fcitx5"
        "systemctl --user start kanshi.service"
        "systemctl --user import-environment" # ensure that the environment variables are correctly set for the user systemd units
        "${pkgs.hyprpaper}/bin/hyprpaper" # wallpaper
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.mako}/bin/mako --default-timeout 5000" # notification
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store" # clipboard
        "${pkgs.swayest-workstyle}/bin/sworkstyle" # better workspace
        "${pkgs.wlsunset}/bin/wlsunset -t 0 -l 21.0 -L 105.8" # # Hanoi lat/long for wlsunset and max warm
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
