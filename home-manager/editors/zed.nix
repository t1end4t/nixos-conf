{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
  };

  home.packages = with pkgs; [
    vulkan-tools
  ];
}
