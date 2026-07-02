{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "Lilex Nerd Font Propo";
        size = 12;
      };

      window = {
        padding = {
          x = 6;
          y = 6;
        };
        opacity = 0.95;
      };

      terminal.shell.program = "${pkgs.nushell}/bin/nu";
    };
  };
}
