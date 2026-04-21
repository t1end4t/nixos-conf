{ pkgs, ... }:
{
  home.packages = with pkgs; [
    code-cursor # just use it for free-tier
  ];
}
