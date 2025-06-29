{
  "spacing" = 4;
  "layer" = "top";

  "modules-left" = [
    "sway/workspaces"
    "sway/window"
  ];
  "modules-center" = [ "clock" ];
  "modules-right" = [
    "bluetooth"
    "network"
    "pulseaudio"
    "tray"
    "battery"
  ];

  "sway/window" = {
    "max-length" = 25;
  };

  "clock" = {
    "min-length" = 10;
    "calendar" = {
      "mode" = "month";
      "mode-mon-col" = 3;
      "weeks-pos" = "right";
      "on-scroll" = 1;
      "on-click-right" = "mode";
      "format" = {
        "days" = "<span color='#89b4fa'><b>{}</b></span>";
        "weeks" = "<span color='#74c7ec'><b>W{}</b></span>";
        "weekdays" = "<span color='#a6e3a1'><b>{}</b></span>";
        "today" = "<span color='#cba6f7'><b>{}</b></span>";
      };
    };
    "format" = "{:%H:%M}  ";
    "format-alt" = "{:%A, %B %d, %Y (%R)}";
    "tooltip-format" = ''
      <big>{:%Y %B}</big>
      <tt><small>{calendar}</small></tt>'';
  };

  "tray" = {
    "icon-size" = 21;
    "spacing" = 10;
  };

  "bluetooth" = {
    "min-length" = 6;
    "format" = " {status}";
    "format-connected" = " {device_alias}";
    "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
    # // "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
    "tooltip-format" = ''
      {controller_alias}	{controller_address}

      {num_connections} connected'';
    "tooltip-format-connected" = ''
      {controller_alias}	{controller_address}

      {num_connections} connected

      {device_enumerate}'';
    "tooltip-format-enumerate-connected" = "{device_alias}	{device_address}";
    "tooltip-format-enumerate-connected-battery" =
      "{device_alias}	{device_address}	{device_battery_percentage}%";
    "on-click-right" = "blueman-manager";
  };

  "network" = {
    "min-length" = 20;
    # "interface": "wlp2*", // (Optional) To force the use of this interface
    "format-wifi" = "{essid} ({signalStrength}%) ";
    "format-ethernet" = "{ipaddr}/{cidr} ";
    "tooltip-format" = "{ifname} via {gwaddr} ";
    "format-linked" = "{ifname} (No IP) ";
    "format-disconnected" = "Disconnected ⚠";
    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    "on-click-right" = "alacritty -e nmtui";
  };

  "pulseaudio" = {
    "min-length" = 14;
    "format" = "{volume}% {icon} {format_source}";
    "format-bluetooth" = "{volume}% {icon} {format_source}";
    "format-bluetooth-muted" = " {icon} {format_source}";
    "format-muted" = " {format_source}";
    "format-source" = "{volume}% ";
    "format-source-muted" = "";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
        ""
      ];
    };
    "on-click-right" = "pavucontrol";
  };

  "battery" = {
    "min-length" = 8;
    "states" = {
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{capacity}% {icon}";
    "format-charging" = "{capacity}% ";
    "format-plugged" = "{capacity}% ";
    "format-alt" = "{time} {icon}";
    "format-icons" = [
      ""
      ""
      ""
      ""
      ""
    ];
  };

}
