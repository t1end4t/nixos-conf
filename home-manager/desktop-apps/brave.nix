{pkgs, ...}: {
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
}
