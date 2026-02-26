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
    };
  };
}
