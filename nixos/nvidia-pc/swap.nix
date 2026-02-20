{
  # source: https://nixos.wiki/wiki/Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
}
