{
  lib,
  pkgs,
  ...
}:
let
  ROOT = builtins.toString ./.;
  keybindings = import "${ROOT}/keybindings.nix" { inherit lib pkgs; };
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

    settings = keybindings // {
      # exec = [
      #   "systemctl --user start hyprpolkitagent"
      #   "fcitx5"
      #   "hyprpaper"
      #   "waybar"
      #   "mako --default-timeout 5000"
      #   "wl-paste --watch cliphist store"
      # ];

      #   config = {
      #     general = {
      #       gaps_in = 2;
      #       gaps_out = 2;
      #       layout = "master";
      #     };

      #     decoration = {
      #       blur.enabled = false;
      #       shadow.enabled = false;
      #     };

      #     input = {
      #       accel_profile = "adaptive";
      #       touchpad = {
      #         natural_scroll = true;
      #         drag_lock = 2;
      #         middle_button_emulation = true;
      #       };
      #     };

      #     cursor = {
      #       hide_on_key_press = true;
      #       inactive_timeout = 3;
      #     };

      #     animations.enabled = false;
      #   };
    };
  };
}
