{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = [ (import ./settings.nix) ];
    style = builtins.readFile ./style.css;
  };
}
