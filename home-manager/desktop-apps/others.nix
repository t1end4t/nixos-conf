{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol # PulseAudio Volume Control
    wdisplays # wlroots compositors
    networkmanagerapplet # NetworkManager control applet for GNOME
    gnome-pomodoro # focus time
    discord # to know more things
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
