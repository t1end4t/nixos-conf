{
  config,
  lib,
  pkgs,
  ...
}:
let
  ROOT = builtins.toString ./.;
  wallpaper = "${ROOT}/wallpapers/aesthetic_deer.jpg";
  cfg = config.local.hyprland;
in
{
  options.local.hyprland.wallpaperOutputs = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    home.packages = with pkgs; [
      hyprpaper # for wallpaper
    ];

    xdg.configFile."hypr/hyprpaper.conf".text = lib.concatMapStrings (output: ''
      wallpaper {
        monitor = ${output}
        path = ${wallpaper}
      }

    '') cfg.wallpaperOutputs;
  };
}
