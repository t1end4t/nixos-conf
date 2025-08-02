{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ./aesthetic_deer.jpg;

    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.nerd-fonts.intone-mono;
        name = "IntoneMono Nerd Font Propo";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

}
