{ pkgs, ... }:

{
  # NOTE: 1280 x 720
  home.packages = with pkgs; [
    # native wayland support
    wineWowPackages.waylandFull
  ];
}
