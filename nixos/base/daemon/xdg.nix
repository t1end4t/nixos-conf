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

  # to use gnome calendar
  # source: https://wiki.nixos.org/wiki/GNOME/Calendar

  # to setup online account: nix-shell -p gnome-control-center --run "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.evolution-data-server.enable = true;
}
