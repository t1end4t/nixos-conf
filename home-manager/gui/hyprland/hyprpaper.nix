{
  config,
  lib,
  pkgs,
  ...
}: let
  ROOT = builtins.toString ./.;
  wallpaper = "${ROOT}/wallpapers/aesthetic_deer.jpg";
  cfg = config.local.hyprland;
in {
  options.local.hyprland.wallpaperOutputs = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
  };

  config = {
    home.packages = with pkgs; [
      hyprpaper # for wallpaper
    ];

    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${wallpaper}
    '' + lib.concatMapStrings (output: ''
      wallpaper = ${output},${wallpaper}
    '') cfg.wallpaperOutputs;
  };
}
