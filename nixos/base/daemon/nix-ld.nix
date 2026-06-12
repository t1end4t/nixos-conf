{ pkgs, ... }:
{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    alsa-lib
    wayland
    libxkbcommon
    vulkan-loader
    libGL
    freetype
    fontconfig
    libX11
    libXcursor
    libXrandr
    libXi
    dbus
  ];
}
