{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Fcitx5#Setup
  # enable vietnames input method
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # ignoreUserConfig = true;
      waylandFrontend = true;
      addons = with pkgs; [
        kdePackages.fcitx5-unikey # vietnamese
      ];
    };
  };
}
