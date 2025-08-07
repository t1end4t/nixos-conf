{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat
    unstable.gemini-cli
  ];
}
