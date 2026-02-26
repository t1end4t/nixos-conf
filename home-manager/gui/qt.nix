{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
    };
  };

  # NOTE: must have with hyprland
  # home.packages = with pkgs; [
  #   qt5.qtwayland
  #   qt6.qtwayland
  # ];
}
