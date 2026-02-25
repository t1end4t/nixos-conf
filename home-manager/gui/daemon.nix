{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # autotiling # tiling behavior like hyprland
    # swayidle # lock screen after time
    # hyprsunset # alternative nightlight
    hyprlock # alternative lock
    wlsunset # control display temperature
    hypridle # alternative daemon
    wlogout # logout menu
    libnotify # to test mako
    wl-clipboard # copy/paste utilities
    cliphist # clipboard manager
    grim # screenshot
    slurp # region screenshot
    swayest-workstyle # icons in workspace
    playerctl # mpris media player command-line
    nwg-look # to set theme for gtk
  ];

  # programs.swaylock = {
  #   enable = true;
  #   package = pkgs.swaylock-effects;
  # };
}
