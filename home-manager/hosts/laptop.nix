{
  imports = [
    ../default.nix
    ../gui/kitty.nix
    ../gui/hyprland/laptop.nix
  ];

  home.username = "tiendat";
  home.homeDirectory = "/home/tiendat";

  programs.kitty.font = {
    name = "Lilex Nerd Font Propo";
    size = 10;
  };
}
