{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sioyek # pdf reader
    koodo-reader # epub reader
    libreoffice-qt # office tools
    inkscape # paper drawing
    obsidian # second brain
  ];
}
