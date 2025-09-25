{ pkgs, ... }:
{
  # source: https://nixos.wiki/wiki/Fonts#Installing_fonts_on_NixOS
  # global fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.lilex # default mono
      corefonts
      # noto-fonts
      # noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome # for waybar
      papirus-icon-theme # for rofi

      # font to pptx
      (google-fonts.override {
        fonts = [
          "IBM Plex Sans" # default sans
          "Roboto Slab" # title
          "Roboto" # body
          "Inter" # san-serif
          # "Merriweather" # serif
          # "Fira Sans" # default firefox
        ];
      })
    ];
    fontconfig.defaultFonts = {
      serif = [ "IBM Plex Sans" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "Lilex Nerd Font Propo" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
