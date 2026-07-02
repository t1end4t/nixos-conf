{ pkgs, ... }:
let
  ROOT = toString ./.;
  lazy-zellij = pkgs.stdenvNoCC.mkDerivation {
    pname = "lazy-zellij";
    version = "3a44fb2";

    src = pkgs.fetchFromGitHub {
      owner = "Logos-Flux";
      repo = "lazy-zellij";
      rev = "3a44fb261ed03aa674003ae04c239a172b39b37e";
      hash = "sha256-1GB+iZ3jWjG+ZXENYh1X1GYUY8gI0F3dp4QZWyyn4Hw=";
    };

    installPhase = ''
      runHook preInstall
      install -Dm755 bin/lzj bin/zj bin/lzj-snapshot -t $out/bin
      runHook postInstall
    '';
  };
in
{
  home.packages = with pkgs; [
    fzf
    lazy-zellij
    python3
    zellij # terminal workspace
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = "${ROOT}/config.kdl";
  };
}
