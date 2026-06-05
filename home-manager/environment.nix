{ pkgs, ... }:
{
  home.sessionVariables = {
    # source: https://nixos.wiki/wiki/Firefox#Screen_Sharing_under_Wayland
    EDITOR = "hx";
    BROWSER = "firefox";

    # unset this
    GTK_IM_MODULE = "";
    QT_IM_MODULE = "";
    XMODIFIERS = "";
    SDL_IM_MODULE = "";
  };
}
