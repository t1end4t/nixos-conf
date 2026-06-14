{
  imports = [
    ../default.nix
    ../research
    ../gui/kitty.nix
    ../gui/hyprland/workstation.nix
  ];

  home.username = "tiendat";
  home.homeDirectory = "/home/tiendat";

  programs.kitty.font = {
    name = "Lilex Nerd Font Propo";
    size = 12;
  };
}
