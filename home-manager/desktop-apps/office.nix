{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt # office tools
    koodo-reader # epub reader
    # obsidian # second brain
    # inkscape # vector image for papers
  ];

  # NOTE: hot fix when sioyek not display
  # source: https://github.com/NixOS/nixpkgs/issues/432137
  programs.sioyek = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "sioyek-hotfix";
      paths = [ pkgs.sioyek ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/sioyek \
          --set QT_QPA_PLATFORM xcb \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pkgs.pipewire ]}
      '';
    };
  };
}
