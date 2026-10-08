{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt
    # koodo-reader # epub reader
    obsidian # second brain
    inkscape # vector image for papers
  ];

  programs.sioyek.enable = true;
}
