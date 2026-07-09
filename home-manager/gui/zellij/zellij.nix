{ pkgs, ... }:
let
  ROOT = toString ./.;
in
{
  home.packages = with pkgs; [
    fzf
    # jq # already installed
    python3
    zellij # terminal workspace
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = "${ROOT}/config.kdl";
  };

  xdg.configFile."zellij/session-picker.nu" = {
    source = "${ROOT}/session-picker.nu";
  };
}
