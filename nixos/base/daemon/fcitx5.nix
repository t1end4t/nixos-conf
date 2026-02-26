{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Fcitx5#Setup
  # enable vietnames input method
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # i18n.inputMethod = {
  #   enable = true;
  #   type = "fcitx5";
  #   fcitx5.addons = with pkgs; [ qt6Packages.fcitx5-unikey ];
  # };
}
