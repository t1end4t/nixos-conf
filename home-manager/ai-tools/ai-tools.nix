{
  pkgs,
  opencode,
  zeroclaw,
  ...
}:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    unstable.aider-chat-with-playwright

    # using nix flake to install
    opencode.packages.${pkgs.system}.default
    # zeroclaw.packages.${pkgs.system}.default

    # to install gemini-cli and claude-code
    # npm set prefix ~/.npm-global
    # npm i -g @musistudio/claude-code-router
    # npm i -g @anthropic-ai/claude-code
    # npm i -g @google/gemini-cli
    # npm i -g @openai/codex
    nodejs

    # to install gptme
    python312
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
