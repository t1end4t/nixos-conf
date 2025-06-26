{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs # to install gemini
  ];
}
