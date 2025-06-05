{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.aider-chat # try this tools
  ];
}
