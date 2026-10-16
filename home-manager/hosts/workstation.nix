{pkgs, ...}: {
  imports = [
    ../default.nix
    ../research
    ../gui/kitty.nix
    ../gui/hyprland/workstation.nix
  ];

  home.username = "tiendat";
  home.homeDirectory = "/home/tiendat";

  programs.kitty.font = {
    name = "Lilex Nerd Font Propo";
    size = 12;
  };

  # ponytail: NVIDIA EGL fails on native Wayland; drop after driver/Sioyek fix.
  programs.sioyek.package = pkgs.symlinkJoin {
    name = "sioyek-xcb";
    paths = [pkgs.sioyek];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = "wrapProgram $out/bin/sioyek --set QT_QPA_PLATFORM xcb";
  };
}
