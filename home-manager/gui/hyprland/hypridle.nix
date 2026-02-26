{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        # --- dim screen after 4.5 min ---
        # {
        #   timeout = 270;
        #   on-timeout = "brightnessctl set 20%";
        #   on-resume = "brightnessctl set 100%";
        # }

        # --- lock after 5 min ---
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }

        # --- screen off after 10 min ---
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
