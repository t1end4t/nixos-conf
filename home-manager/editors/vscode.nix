{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
        github.copilot
      ];
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
        "editor.minimap.enabled" = false;
        "baml.bamlPanelOpen" = true;
      };
    };
  };
}
