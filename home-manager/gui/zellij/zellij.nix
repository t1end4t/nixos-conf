{ pkgs, ... }:
let
  ROOT = toString ./.;
in
{
  home.packages = with pkgs; [
    fzf
    zellij # terminal workspace
    # jq # already installed
    # python3
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = "${ROOT}/config.kdl";
  };
}
