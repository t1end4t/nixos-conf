{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat # will replace by hinty soon
    unstable.gemini-cli
  ];
}
