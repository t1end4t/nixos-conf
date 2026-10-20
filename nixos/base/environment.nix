{ pkgs, ... }:
{
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      vim
      wget
      curl
      xdg-utils
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      XKB_CONFIG_ROOT = "${pkgs.xkeyboard_config}/share/X11/xkb";
    };
  };
}
