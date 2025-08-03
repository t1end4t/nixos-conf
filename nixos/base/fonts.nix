{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Fonts#Installing_fonts_on_NixOS
  # global fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.intone-mono
      corefonts
      # noto-fonts
      # noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome # for waybar
      papirus-icon-theme # for rofi

      # font to pptx
      (google-fonts.override {
        fonts = [
          "Roboto Slab" # title
          "Roboto" # body
          "Inter" # body
          "Fira Sans" # default firefox
        ];
      })
    ];
    fontconfig.defaultFonts = {
      serif = [ "Fira Sans" ];
      sansSerif = [ "Fira Sans" ];
      monospace = [ "IntoneMono Nerd Font Propo" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
