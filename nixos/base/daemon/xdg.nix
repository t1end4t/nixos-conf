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
        "application/pdf" = "firefox.desktop";
        "application/msword" = "writer.desktop";
        "application/rtf" = "writer.desktop";
        "application/vnd.ms-excel" = "calc.desktop";
        "application/vnd.ms-powerpoint" = "impress.desktop";
        "application/vnd.oasis.opendocument.presentation" = "impress.desktop";
        "application/vnd.oasis.opendocument.spreadsheet" = "calc.desktop";
        "application/vnd.oasis.opendocument.text" = "writer.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "impress.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
        "image/png" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "text/csv" = "calc.desktop";
        "video/mp4" = "mpv.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };

  services.dbus.packages = [ pkgs.gnome-keyring ];
  services.gnome.gnome-keyring.enable = true;
}
