{ ... }:
let
  ROOT = toString ./.;
in
{
  xdg.configFile."fcitx5/profile" = {
    source = "${ROOT}/profile";
    force = true;
  };
}
