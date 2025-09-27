{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arduino # for upload iot
  ];
}
