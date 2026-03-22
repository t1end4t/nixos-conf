{ ... }:
{
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-3,1920x1080@60,0x0,1"
      "HDMI-A-1,1360x768@60,1920x0,1"
    ];
    workspace = [
      "1, monitor:DP-3"
      "2, monitor:HDMI-A-1"
    ];
  };
}
