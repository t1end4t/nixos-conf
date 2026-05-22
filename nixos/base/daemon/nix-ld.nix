{ pkgs, ... }:
{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl

    # jcode packages
    krb5
    e2fsprogs

  ];
}
