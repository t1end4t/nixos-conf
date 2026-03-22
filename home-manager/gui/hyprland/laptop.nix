{ ... }:
{
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,1360x768@60,0x0,1"
      "eDP-1,1360x768@60,1360x0,1"
    ];
    workspace = [
      "1, monitor:HDMI-A-1"
      "2, monitor:eDP-1"
    ];
  };
}
