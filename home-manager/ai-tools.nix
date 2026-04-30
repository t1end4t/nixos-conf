{
  pkgs,
  ...
}:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    ############ claude-code ############
    # curl -fsSL https://claude.ai/install.sh | bash
    # curl -fsSL https://opencode.ai/install | bash
    # npm install -g @anthropic-ai/sandbox-runtime

    ############ router ############
    # npm set prefix ~/.npm-global
    # npm install -g omniroute
    nodejs

    # uvx --from git+https://github.com/oraios/serena serena
    python313
    uv

    # download model
    python313Packages.huggingface-hub
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
