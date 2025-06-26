{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs # to install gemini
  ];

  # try to run: npm set prefix ~/.npm-global
}
