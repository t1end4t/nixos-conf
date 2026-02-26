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
        "systemctl --user start kanshi.service"
        "systemctl --user start ${pkgs.hyprpolkitagent}/bin/hyprpolkitagent"
        "${pkgs.fcitx5}/bin/fcitx5"
        "${pkgs.hyprpaper}/bin/hyprpaper" # wallpaper
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.mako}/bin/mako --default-timeout 5000" # notification
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store" # clipboard
      ];

      # "${pkgs.wlsunset}/bin/wlsunset -t 0 -l 21.0 -L 105.8" # Hanoi lat/long for wlsunset and max warm

      # gaps
      general = {
        gaps_in = 2;
        gaps_out = 2;

      };

      # cursor
      cursor = {
        hide_on_key_press = true;
        inactive_timeout = 3;
      };

      # turn off animations
      animations = {
        enabled = false;
      };

      # keybindings
      bind = import "${ROOT}/keybindings.nix" { inherit pkgs; };
    };
  };
}
