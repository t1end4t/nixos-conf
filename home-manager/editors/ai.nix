{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat-with-playwright # will replace by hinty soon

    # to install gemini-cli and claude-code
    # npm install -g @musistudio/claude-code-router
    # npm install -g @anthropic-ai/claude-code
    # npm install -g @google/gemini-cli
    nodejs
  ];
}
