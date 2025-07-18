{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.gemini-cli # to work with gemini
  ];
}
