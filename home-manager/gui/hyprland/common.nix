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
        "systemctl --user start hyprpolkitagent"
        "fcitx5" # unikey
        "hyprpaper" # wallpaper
        "waybar" # status bar
        "mako --default-timeout 5000" # notification
        "wl-paste --watch cliphist store" # clipboard
      ];

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

      # touchpad + mouse input configuration (Windows-like behavior)
      input = {
        touchpad = {
          natural_scroll = true; # like Windows/macOS
          drag_lock = 2; # better drag behavior
          middle_button_emulation = true;
        };
        accel_profile = "adaptive"; # similar to Windows acceleration
      };

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
