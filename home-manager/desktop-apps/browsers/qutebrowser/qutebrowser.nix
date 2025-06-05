{ pkgs, catppuccin-qutebrowser, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    qutebrowser # other browser
  ];

  home.file.".config/qutebrowser/config.py" = {
    source = "${ROOT}/config.py";
  };

  # theme
  home.file.".config/qutebrowser/catppuccin" = {
    source = "${catppuccin-qutebrowser}";
    recursive = true;
  };

  # block specific sites
  home.file.".config/qutebrowser/blocked-hosts" = {
    source = "${ROOT}/blocked-hosts";
  };
}
