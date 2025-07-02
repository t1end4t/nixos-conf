{
  programs.proxychains = {
    enable = true;
    proxies = {
      myproxy = {
        enable = true;
        type = "http";
        host = "103.164.133.26"; # Example SG proxy
        port = 8080;
      };
    };
  };
}
