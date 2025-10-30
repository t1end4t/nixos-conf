{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # pkief.material-icon-theme
        # ms-python.python
      ];
      userSettings = {
        "editor.minimap.enabled" = false;
        "baml.bamlPanelOpen" = true;
        "python.analysis.typeCheckingMode" = "standard";
      };
    };
  };
}
