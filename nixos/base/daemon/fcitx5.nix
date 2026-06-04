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
        fcitx5-gtk
        fcitx5-nord
        qt6Packages.fcitx5-unikey
      ];
      settings.inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "unikey";
      };
    };
  };
}
