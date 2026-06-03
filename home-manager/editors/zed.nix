{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = false;
    package = pkgs.unstable.zed-editor;
  };

  home.packages = with pkgs; [
    vulkan-tools
  ];
}
