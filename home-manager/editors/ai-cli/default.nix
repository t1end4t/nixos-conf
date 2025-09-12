{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    unstable.aider-chat-with-playwright # will replace by hinty soon

    # to install gemini-cli and claude-code
    # npm set prefix ~/.npm-global
    # npm install -g @musistudio/claude-code-router
    # npm install -g @anthropic-ai/claude-code
    # npm install -g @google/gemini-cli
    nodejs
  ];

  # create symlink for secret aider and aider example
  home.file.".aider.conf.yml.gpg" = {
    source = "${ROOT}/secrets/aider.conf.yml.gpg";
  };

  home.file.".claude-code-router/config.json.gpg" = {
    source = "${ROOT}/secrets/claude-code-router-config.json.gpg";
  };
}
