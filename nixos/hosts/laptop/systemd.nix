{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # turn off computer everyday
  # source: https://wiki.nixos.org/wiki/Systemd/timers
  # systemd.timers."shutdown-daily" = {
  #   description = "daily shutdown timer";
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     # source: https://man.archlinux.org/man/systemd.time.7
  #     # force turn off before 10PM until 3AM
  #     OnCalendar = "*-*-* 22..23,00..02:*:00";
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
