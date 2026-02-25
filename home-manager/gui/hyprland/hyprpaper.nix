{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    hyprpaper # for wallpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${ROOT}/wallpapers/aesthetic_deer.jpg
    wallpaper = ,${ROOT}/wallpapers/aesthetic_deer.jpg
  '';
}
