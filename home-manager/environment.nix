{pkgs, ...}: {
  home.sessionVariables = {
    EDITOR = "hx";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";

    # unset this
    GTK_IM_MODULE = "";
    QT_IM_MODULE = "";
    XMODIFIERS = "";
    SDL_IM_MODULE = "";
  };
}
