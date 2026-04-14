{
  pkgs,
  ...
}:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    ############ aider ############
    # unstable.aider-chat-with-playwright

    ############ claude-code ############
    # curl -fsSL https://claude.ai/install.sh | bash
    # npm install -g @anthropic-ai/sandbox-runtime

    ############ codex ############
    # npm set prefix ~/.npm-global
    # npm i -g @openai/codex
    # npm install -g @qwen-code/qwen-code@latest
    nodejs

    ############ router ############
    # npm install -g 9router

    # bun add -g opencode-ai
    bun

    # uvx --from git+https://github.com/oraios/serena serena
    python313
    uv
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
