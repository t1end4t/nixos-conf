{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      pkief.material-icon-theme
      saoudrizwan.claude-dev
    ];
  };

  home.file.".config/Code/User/settings.json" = {
    source = "${ROOT}/settings.json";
  };
}
