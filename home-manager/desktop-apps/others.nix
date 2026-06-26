{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol # PulseAudio Volume Control
    wdisplays # wlroots compositors
    networkmanagerapplet # NetworkManager control applet for GNOME
    discord # to know more things
    gnome-pomodoro # focus time
    gnome-calendar # calendar app
  ];

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = with pkgs.obs-studio-plugins; [
  #     wlrobs
  #     # obs-backgroundremoval
  #     # obs-pipewire-audio-capture
  #   ];
  # };
}
