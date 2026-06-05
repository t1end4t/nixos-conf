{ pkgs, ... }:
let
  yaziWithoutUeberzugpp = pkgs.symlinkJoin {
    name = "yazi-without-ueberzugpp";
    paths = [ pkgs.yazi ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/yazi --unset XDG_SESSION_TYPE
    '';
  };
in
{
  home.packages = with pkgs; [
    chafa # fallback image previews
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
    package = yaziWithoutUeberzugpp;
    settings.preview = {
      max_width = 1000;
      max_height = 1000;
    };
  };
}
