{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      # General idle behavior
      general = {
        # avoid starting multiple hyprlock instances
        lock_cmd = "pidof hyprlock || hyprlock";

        # lock before suspend
        before_sleep_cmd = "loginctl lock-session";

        # turn display back on after resume
        # prevents needing to press a key twice
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # 2.5 min → dim screen
          timeout = 150;

          # set monitor backlight to minimum
          # avoid 0 on OLED monitor
          on-timeout = "brightnessctl -s set 10";

          # restore monitor brightness
          on-resume = "brightnessctl -r";
        }

        # {
        #   # 2.5 min → keyboard backlight off
        #   # comment this block if no keyboard backlight
        #   timeout = 150;

        #   # turn off keyboard backlight
        #   on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";

        #   # restore keyboard backlight
        #   on-resume = "brightnessctl -rd rgb:kbd_backlight";
        # }

        {
          # 5 min → lock screen
          timeout = 300;

          # lock session
          on-timeout = "loginctl lock-session";
        }

        {
          # 5.5 min → screen off
          timeout = 330;

          # turn display off
          on-timeout = "hyprctl dispatch dpms off";

          # turn display on + restore brightness
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }

        {
          # 30 min → suspend PC
          timeout = 1800;

          # suspend system
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
