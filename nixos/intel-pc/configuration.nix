{ inputs, pkgs, ... }:
let
  userName = "icslab";
in
{
  imports = [
    ./hardware-configuration.nix
    ./systemd.nix
    ./swap.nix
    ../base
    ./dns/dns.nix
  ];

  # allow your normal user to use extra substituters
  nix.settings.trusted-users = [
    "root"
    "icslab"
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
    ];
    # evaluation warning: 'system' has been renamed to/replaced by 'stdenv.hostPlatform.system'
    packages = [ inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };

  environment.sessionVariables = {
    # source: https://github.com/vimjoyer/nix-helper-video?tab=readme-ov-file#defining-flake
    NH_FLAKE = "/home/${userName}/nix-dev/nixos-conf";
  };
}
