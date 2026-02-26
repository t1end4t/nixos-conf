{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # create symlink for fcitx5 profile
  home.file.".config/fcitx5/profile" = {
    source = "${ROOT}/profile";
    # recursive = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ qt6Packages.fcitx5-unikey ];
  };

}
