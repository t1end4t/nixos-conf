{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.aichat # cli LLM
  ];
}
