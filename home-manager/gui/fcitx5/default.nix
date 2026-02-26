{ ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # create symlink for fcitx5 profile
  home.file.".config/fcitx5/profile" = {
    source = "${ROOT}/profile";
    # recursive = true;
  };
}
