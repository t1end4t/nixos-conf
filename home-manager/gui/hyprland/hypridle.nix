{ pkgs, ... }:
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
        # --- TEST: notify after 10s idle ---
        {
          timeout = 10;
          on-timeout = "${pkgs.libnotify}/bin/notify-send 'Idle 10s' 'No interaction detected'";
          on-resume = "${pkgs.libnotify}/bin/notify-send 'Active again'";
        }

        # --- lock after 15 min ---
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }

        # --- DPMS off after 20 min ---
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
