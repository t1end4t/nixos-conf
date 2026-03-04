{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    unstable.ollama-cuda # quick test
    unstable.llama-cpp # deep dive
  ];
}
