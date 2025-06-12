{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
  settings_toml = (builtins.readFile "${ROOT}/config.toml");
in
# languages_toml = (builtins.readFile "${ROOT}/languages.toml");
{
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    defaultEditor = true;
    settings = (builtins.fromTOML settings_toml);
    # languages = (builtins.fromTOML languages_toml);
  };

  # grammar checker
  home.packages = with pkgs; [
    unstable.harper
  ];

  # example of language.toml
  home.file.".config/helix/languages.example.toml" = {
    source = "${ROOT}/languages.example.toml";
  };

  # italics for comments sections
  catppuccin.helix.useItalics = true;
}
