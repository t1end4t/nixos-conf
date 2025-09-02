{
  # source: https://nixos.wiki/wiki/Encrypted_DNS
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };
}
