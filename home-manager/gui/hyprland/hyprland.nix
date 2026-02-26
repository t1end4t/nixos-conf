{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprsunset.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # daemon
      exec-once = [
        "systemctl --user start kanshi.service"
        "systemctl --user start hyprpolkitagent"
        "fcitx5" # unikey
        "hyprpaper" # wallpaper
        "waybar" # status bar
        "mako --default-timeout 5000" # notification
        "wl-paste --watch cliphist store" # clipboard
        # "wlsunset -t 0 -l 21.0 -L 105.8" # Hanoi lat/long for wlsunset and max warm
      ];

      # "${pkgs.wlsunset}/bin/wlsunset -t 0 -l 21.0 -L 105.8" # Hanoi lat/long for wlsunset and max warm

      # gui settings
      general = {
        gaps_in = 2;
        gaps_out = 2;
        layout = "master";
      };

      # turn off several effect
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };

      # multiple monitors
      monitor = [
        "DP-3,1920x1080@60,0x0,1"
        "HDMI-A-1,1360x768@60,1920x0,1"
      ];

      # main windows
      workspace = [
        "1, monitor:DP-3"
        "2, monitor:HDMI-A-1"
      ];

      # cursor hiding
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
