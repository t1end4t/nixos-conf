{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Firefox#Screen_Sharing_under_Wayland
  # enable xdg desktop integration for screen sharing
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    # source: https://mynixos.com/options/xdg.mime
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
        "image/png" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "video/mp4" = "mpv.desktop";
      };
    };
  };
}
