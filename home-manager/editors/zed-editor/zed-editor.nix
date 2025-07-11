{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    userSettings = {
      helix_mode = true;
      relative_line_numbers = true;
    };
  };

  # enable api setup
  services.gnome-keyring.enable = true;

  # custom keymap
  home.file.".config/zed/keymap.json" = {
    source = "${ROOT}/keymap.json";
  };
}
