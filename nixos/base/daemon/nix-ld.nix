{pkgs, ...}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    openssl
    stdenv.cc.cc
    wayland
    vulkan-loader
    zlib
  ];
}
