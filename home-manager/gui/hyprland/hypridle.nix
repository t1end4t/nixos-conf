{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"on\" })'";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        # {
        #   timeout = 10;
        #   on-timeout = "notify-send \"You are idle!\"";
        #   on-resume = "notify-send \"Welcome back!\"";
        # }

        # --- dim screen after 4.5 min ---
        # {
        #   timeout = ;
        #   on-timeout = "brightnessctl set 20%";
        #   on-resume = "brightnessctl set 100%";
        # }

        # --- lock after 2.5 min ---
        {
          timeout = 150;
          on-timeout = "hyprlock";
        }

        # --- screen off after 3 min ---
        {
          timeout = 180;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"off\" })'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"on\" })'";
        }
      ];
    };
  };
}
