{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.targets.gnome.enable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.image = ./aesthetic_deer.jpg;
}
