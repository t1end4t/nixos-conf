{
  description = "t1endat's config for NixOs";

  # caching
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin for nix
    catppuccin.url = "github:catppuccin/nix";

    # non-flake repositories
    nushell-defaultConfig = {
      url = "github:nushell/nushell";
      flake = false;
    };

    # make firefox faster
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

    # catppuccin for qutebrowser
    catppuccin-qutebrowser = {
      url = "github:catppuccin/qutebrowser";
      flake = false;
    };

    # set theme and font
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nushell-defaultConfig,
      betterfox,
      catppuccin,
      catppuccin-qutebrowser,
      stylix,
      ...
    }@inputs:
    let
      # custom user and host
      users = [
        "tiendat"
        "icslab"
      ];
      hosts = [
        "lenovo-laptop"
        "intel-pc"
      ];
      userToAttrs = builtins.listToAttrs (
        builtins.map (user: {
          name = user;
          value = null;
        }) users
      );
      hostToAttrs = builtins.listToAttrs (
        builtins.map (host: {
          name = host;
          value = null;
        }) hosts
      );

      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;

    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = builtins.mapAttrs (
        host: value:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            # inherit inputs outputs platformio-udev;
          };
          modules = [
            ./nixos/${host}/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
          ];
        }
      ) hostToAttrs;

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = builtins.mapAttrs (
        user: value:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              inputs
              outputs
              nushell-defaultConfig
              catppuccin-qutebrowser
              betterfox
              ;
          };
          modules = [
            ./home-manager/hosts/${user}.nix
            catppuccin.homeModules.catppuccin
            stylix.homeModules.stylix
          ];
        }
      ) userToAttrs;
    };
}
