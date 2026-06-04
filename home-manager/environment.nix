{ pkgs, ... }:
{
  home.sessionVariables = {
    # source: https://nixos.wiki/wiki/Firefox#Screen_Sharing_under_Wayland
    # only needed for Sway
    # XDG_CURRENT_DESKTOP = "sway";
    EDITOR = "hx";
    BROWSER = "firefox";

    # for using aider
    # PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";

    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";

    # enable claude config for opencode
    # OPENCODE_DISABLE_CLAUDE_CODE = 0;

    # local model only
    # OLLAMA_NO_CLOUD = 1;
  };
}
