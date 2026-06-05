{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "Lilex Nerd Font Propo";
      size = 12;
    };

    settings = {
      background_opacity = "0.95";
      shell = "${pkgs.zellij}/bin/zellij";
      window_padding_width = 6;
    };
  };
}
