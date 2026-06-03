{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xkeyboard_config
    libxkbcommon
  ];

  environment.sessionVariables = {
    XKB_CONFIG_ROOT = "${pkgs.xkeyboard_config}/share/X11/xkb";
  };
}
