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
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.waybar}/bin/waybar"
        "fcitx5"
        "${pkgs.mako}/bin/mako --default-timeout 5000"
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store" # Stores only image data
        "${pkgs.swayest-workstyle}/bin/sworkstyle" # better workspace
        "systemctl --user start kanshi.service"
      ];

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

      # keybindings
      bind = import "${ROOT}/keybindings.nix" { inherit pkgs; };
    };
  };
}
