{ pkgs, ... }:
{
  home.sessionVariables = {
    # source: https://nixos.wiki/wiki/Firefox#Screen_Sharing_under_Wayland
    EDITOR = "hx";
    BROWSER = "firefox";
  };
}
