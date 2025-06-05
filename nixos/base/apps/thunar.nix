{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Thunar
  # thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # source: https://www.reddit.com/r/NixOS/comments/15sip8b/thunar_archiver_extension_not_working/
  programs.file-roller.enable = true;

  # other functionalities for nixos
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
