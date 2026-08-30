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

      # for codex and claude-code
      bubblewrap
      socat

      # for claude-desktop cowork VM
      qemu_kvm
      virtiofsd
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      XKB_CONFIG_ROOT = "${pkgs.xkeyboard_config}/share/X11/xkb";
    };
  };

  systemd.tmpfiles.rules = [
    "d /usr/bin 0755 root root -"
    "L /usr/bin/bwrap - - - - ${pkgs.bubblewrap}/bin/bwrap"
    # cowork looks up these Debian paths directly
    "L+ /usr/bin/virtiofsd - - - - ${pkgs.virtiofsd}/bin/virtiofsd"
    "d /usr/share/OVMF 0755 root root -"
    "L+ /usr/share/OVMF/OVMF_CODE.fd - - - - ${pkgs.OVMF.firmware}"
    "L+ /usr/share/OVMF/OVMF_VARS.fd - - - - ${pkgs.OVMF.variables}"
  ];
}
