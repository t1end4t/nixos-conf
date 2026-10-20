{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-ssh
        ms-python.python
        # sst-dev.opencode
      ];

      userSettings = {
        "editor.minimap.enabled" = false;
      };
    };
  };
}
