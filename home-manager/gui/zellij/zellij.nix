{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # NOTE: can not convert .kdl file to .yaml, have to use pkgs instead
  # programs of home-manager
  home.packages = with pkgs; [
    zellij # terminal workspace
  ];

  # config file
  home.file.".config/zellij/config.kdl" = {
    source = "${ROOT}/config.kdl";
  };
}
