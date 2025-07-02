{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd # alternative of find
    zoxide # alternative of cd
    ripgrep # recursively searches directories
    eza # a modern replacement for ls
    du-dust # a more intuitive version of du in rust
    silver-searcher # a code-searching tool similar to ack, but faster
    tldr # collaborative cheatsheets for console commands
    atuin # history shell
    trash-cli # alternative for rm
    just # A handy way to save and run project-specific commands
    unzip # .zip files
    nh # nix cli helper
    neofetch # system info script

    proxychains4
  ];

  programs.bat.enable = true; # alternative of cat
}
