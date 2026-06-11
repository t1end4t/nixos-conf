{ pkgs, ... }:
{
  home.packages = with pkgs; [
    file # required by yazi
    (ffmpeg-full.override { withUnfree = true; })
    _7zz # archive preview
    jq # yazi plugin for JSON preview
    poppler # yazi plugin for PDF preview
    resvg # yazi plugin for SVG preview
    imagemagick # font, HEIC, and JPEG XL preview
  ];

  programs.yazi = {
    enable = true; # terminal file manager
  };
}
