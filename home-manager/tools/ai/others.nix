{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # unstable.gemini-cli # to work with gemini

    # npm set prefix ~/.npm-global
    nodejs
  ];
}
