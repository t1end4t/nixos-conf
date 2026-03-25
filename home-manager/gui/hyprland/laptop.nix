{ ... }:
{
  imports = [ ./common.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,1360x768@60,0x0,1"
      "eDP-1,1360x768@60,auto-right,1"
      ",preferred,auto,1"
    ];
    workspace = [
      "1, monitor:eDP-1, default:true"
      "2, monitor:HDMI-A-1, default:true"
    ];
  };
}
