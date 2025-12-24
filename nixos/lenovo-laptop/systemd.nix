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
}
