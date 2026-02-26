{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # hyprland equivalents
    hyprlock # screen lock for Hyprland
    hyprpolkitagent # polkit authentication daemon.
    hyprsunset # blue light filter

    wl-clipboard # copy/paste utilities
    wlogout # logout menu
    libnotify # to test mako
    cliphist # clipboard manager
    grim # screenshot
    slurp # region screenshot
    playerctl # mpris media player command-line
    nwg-look # to set theme for gtk
  ];
}
