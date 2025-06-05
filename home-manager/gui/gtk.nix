{ pkgs, ... }:
{
  gtk = {
    enable = true;

    # source: https://www.youtube.com/watch?v=m_6eqpKrtxk
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    # source: https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
  };
}
