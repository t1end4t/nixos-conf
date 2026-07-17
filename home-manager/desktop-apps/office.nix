{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt # office tools
    koodo-reader # epub reader
    obsidian # second brain
    # inkscape # vector image for papers
  ];
}
