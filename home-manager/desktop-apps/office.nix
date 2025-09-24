{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sioyek # pdf reader
    koodo-reader # epub reader
    libreoffice-qt # office tools
    obsidian # second brain
  ];
}
