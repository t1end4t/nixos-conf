{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
      ];
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
      };
    };
  };
}
