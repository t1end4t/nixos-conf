{ ... }:
{
  # source: https://nixos.wiki/wiki/Bluetooth#Enabling_Bluetooth_support
  # enable bluetooth
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
}
