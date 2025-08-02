{ pkgs, config, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # image = "${ROOT}/wallpapers/aesthetic_deer.jpg";
    image = ./wallpapers/aesthetic_deer.jpg;

    targets.firefox.profileNames = [
      "default"
    ];

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
