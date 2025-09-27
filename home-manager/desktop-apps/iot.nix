{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arduino-ide # for upload iot
    screen # check port
    python310 # to build
  ];
}
