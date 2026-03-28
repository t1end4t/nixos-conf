{
  pkgs,
  ...
}:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    # unstable.aider-chat-with-playwright

    # to install gemini-cli and claude-code
    # npm set prefix ~/.npm-global
    # npm i -g @musistudio/claude-code-router
    # npm i -g @anthropic-ai/claude-code
    # npm i -g @openai/codex
    nodejs

    # bun add -g opencode-ai
    bun

    # uvx --from git+https://github.com/oraios/serena serena
    python313
    uv
  ];

  # remember login
  services.gnome-keyring.enable = true;

  # create symlink for secret aider and aider example
  home.file.".aider.conf.yml.gpg" = {
    source = "${ROOT}/secrets/aider.conf.yml.gpg";
  };

  home.file.".claude-code-router/config.json.gpg" = {
    source = "${ROOT}/secrets/claude-code-router-config.json.gpg";
  };
}
