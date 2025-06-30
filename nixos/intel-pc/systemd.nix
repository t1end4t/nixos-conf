{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # source: https://nixos.wiki/wiki/Sway#Systemd_services
  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon for multiple monitor layout";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c ${ROOT}/kanshi_config";
    };
  };

  # # turn off computer everyday
  # # source: https://wiki.nixos.org/wiki/Systemd/timers
  # systemd.timers."shutdown-daily" = {
  #   description = "daily shutdown timer";
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     # source: https://man.archlinux.org/man/systemd.time.7
  #     # force turn off before 9PM until 4AM
  #     OnCalendar = "*-*-* 21..23,00..03:*:00";
  #     Persistent = true;
  #     Unit = "shutdown-daily.service";
  #   };
  # };
  # systemd.services."shutdown-daily" = {
  #   description = "force to shutdown daily";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "/run/current-system/sw/bin/systemctl poweroff";
  #   };
  # };

}
