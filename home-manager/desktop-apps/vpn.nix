{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonvpn-gui # for connect vpn
  ];
}
