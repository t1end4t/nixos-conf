{ pkgs, ... }:
let
  ROOT = toString ./.;
  settings_toml = (builtins.readFile "${ROOT}/config.toml");
  languages_toml = (builtins.readFile "${ROOT}/languages.toml");
in
{
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    defaultEditor = true;
    settings = (fromTOML settings_toml);
    languages = (fromTOML languages_toml);
  };

  # grammar checker
  home.packages = with pkgs; [
    harper
  ];

  # italics for comments sections
  catppuccin.helix.useItalics = true;
}
