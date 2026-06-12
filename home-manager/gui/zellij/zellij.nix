{ pkgs, ... }:
let
  ROOT = toString ./.;
in
{
  # NOTE: can not convert .kdl file to .yaml, have to use pkgs instead
  # programs of home-manager
  home.packages = with pkgs; [
    zellij # terminal workspace
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = "${ROOT}/config.kdl";
  };
}
