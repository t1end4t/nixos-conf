{ pkgs, ... }:
{
  # connect through USB
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    (calibre.override {
      unrarSupport = true;
    })
  ];
}
