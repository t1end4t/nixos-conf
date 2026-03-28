{ pkgs, ... }:
{
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      vim
      wget
      curl
      xdg-utils

      # for codex
      bubblewrap
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  systemd.tmpfiles.rules = [
    "d /usr/bin 0755 root root -"
    "L /usr/bin/bwrap - - - - ${pkgs.bubblewrap}/bin/bwrap"
  ];
}
