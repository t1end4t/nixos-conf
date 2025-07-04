{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sioyek # pdf reader
    koodo-reader # epub reader
    libreoffice-qt # office tools
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      # obs-backgroundremoval
      # obs-pipewire-audio-capture
    ];
  };
}
