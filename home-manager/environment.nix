{ pkgs, ... }:
{
  home.sessionVariables = {
    # source: https://nixos.wiki/wiki/Firefox#Screen_Sharing_under_Wayland
    EDITOR = "hx";
    BROWSER = "firefox";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

    # unset this
    GTK_IM_MODULE = "";
    QT_IM_MODULE = "";
    XMODIFIERS = "";
    SDL_IM_MODULE = "";
  };
}
