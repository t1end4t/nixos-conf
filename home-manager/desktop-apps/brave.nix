{pkgs, ...}: {
  home.sessionVariables.BROWSER = "brave";

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
      {id = "omghfjlpggmjjaagoclmmobgdodcjboh";} # Browsec VPN
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "jhnleheckmknfcgijgkadoemagpecfol";} # Auto Tab Discard
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # Vimium (Tridactyl alternative)
      {id = "khncfooichmfjbepaaaebmommgaepoid";} # Unhook (YouTube recommendations and Shorts)
      {id = "hlepfoohegkhhmjieoechaddaejaokhf";} # Refined GitHub
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
    };
  };
}
