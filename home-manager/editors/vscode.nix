{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
      ];
      userSettings = {
        "editor.minimap.enabled" = false;
        "baml.bamlPanelOpen" = true;
      };
    };
  };
}
