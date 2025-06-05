{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Fonts#Installing_fonts_on_NixOS
  # global fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.intone-mono
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      font-awesome # for waybar
      papirus-icon-theme # for rofi
    ];
    fontconfig.defaultFonts = {
      serif = [ "IntoneMono Nerd Font Propo" ];
      sansSerif = [ "IntoneMono Nerd Font Propo" ];
      monospace = [ "IntoneMono Nerd Font Propo" ];
      emoji = [ "IntoneMono Nerd Font Propo" ];
    };
  };
}
