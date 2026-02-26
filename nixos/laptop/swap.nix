{
  # source: https://nixos.wiki/wiki/Swap
  zramSwap = {
    enable = true;
    memoryPercent = 25; # 8GB max compressed swap
    algorithm = "zstd";
  };
}
