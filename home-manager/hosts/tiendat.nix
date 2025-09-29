{
  imports = [
    ../default.nix
    ./tiendat/iot.nix
  ];

  home.username = "tiendat";
  home.homeDirectory = "/home/tiendat";
}
