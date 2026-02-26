{
  # home-manager for multiple users
  home-manager.users = {
    "tiendat" = {
      imports = [ ./hosts/tiendat.nix ];
    };

    "icslab" = {
      imports = [ ./hosts/icslab.nix ];
    };
  };
}
