{ inputs, pkgs, ... }:
let
  userName = "tiendat";
in
{
  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
    ./systemd.nix
    ../base
    ./dns/dns.nix
    ./swap.nix
  ];

  # allow your normal user to use extra substituters
  nix.settings.trusted-users = [
    "root"
    "tiendat"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "docker"
      "libvirtd"
      "dialout"
      "plugdev"
    ];
    packages = [
      # source: https://github.com/Misterio77/nix-starter-configs?tab=readme-ov-file#use-home-manager-as-a-nixos-module
      inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  users.groups.plugdev = { };
  services.udev.packages = [ pkgs.openocd ];

  environment.sessionVariables = {
    # source: https://github.com/vimjoyer/nix-helper-video?tab=readme-ov-file#defining-flake
    NH_FLAKE = "/home/${userName}/nix-dev/nixos-conf";
  };

}
