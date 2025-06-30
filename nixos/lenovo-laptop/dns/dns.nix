{ ... }:
let
  ROOT = builtins.toString ./.;
in
{
  # source: https://nixos.wiki/wiki/Encrypted_DNS#dnscrypt-proxy2
  networking = {
    nameservers = [ "127.0.0.1" ];
    # If using dhcpcd:
    # dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = false;
      block_ipv6 = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];

      cloaking_rules = "${ROOT}/cloaking-rules.txt";
      blocked_names = {
        blocked_names_file = "${ROOT}/blocked-names.txt";
      };
      allowed_names = {
        allowed_names_file = "${ROOT}/allowed-names.txt";
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

}
