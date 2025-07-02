{ pkgs, ... }:

{
  networking.wg-quick.interfaces =
    let
      server_ip = "138.199.60.2";
    in
    {
      wg0 = {
        # Tunnel IP addresses (from Address = ...)
        address = [
          "10.72.228.31/32"
          "fc00:bbbb:bbbb:bb01::9:e41e/128"
        ];

        # Listen port is optional for client, but okay to set
        listenPort = 51820;

        # Private key path — we'll store it securely
        privateKeyFile = "/etc/wg-client.key";

        # DNS from config (optional but recommended)
        dns = [ "100.64.0.63" ];

        peers = [
          {
            publicKey = "sFHv/qzG7b6ds5pow+oAR3G5Wqp9eFbBD3BmEGBuUWU=";
            allowedIPs = [
              "0.0.0.0/0"
              "::0/0"
            ];
            endpoint = "${server_ip}:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
