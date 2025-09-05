{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat-with-playwright # will replace by hinty soon

    # to install gemini-cli and claude-code
    nodejs
  ];
}
