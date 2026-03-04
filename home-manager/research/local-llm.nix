{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    ollama # quick test
  ];
}
