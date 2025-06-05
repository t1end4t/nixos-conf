{ pkgs, ... }:
{
  home.packages = with pkgs; [
    autotiling # tiling behavior like hyprland
    swayidle # lock screen after time
    libnotify # to test mako
    wl-clipboard # copy/paste utilities
    wlogout # logout menu
    cliphist # clipboard manager
    grim # screenshot
    slurp # region screenshot
    wlsunset # control display temperature
    sov # workspace overview app
    swayest-workstyle # icons in workspace
    playerctl # mpris media player command-line
  ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
