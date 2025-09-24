{ pkgs, ... }:
# let
#   ROOT = builtins.toString ./.;
#   settings_toml = (builtins.readFile "${ROOT}/config.toml");
#   languages_toml = (builtins.readFile "${ROOT}/languages.toml");
# in
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
  };
}
