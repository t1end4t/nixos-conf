{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
  };

  # enable api setup
  services.gnome-keyring.enable = true;
}
