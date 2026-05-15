{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ############ claude-code ############
    # curl -fsSL https://claude.ai/install.sh | bash
    # curl -fsSL https://opencode.ai/install | bash
    # npm install -g @anthropic-ai/sandbox-runtime

    ############ router ############
    # npm set prefix ~/.npm-global
    # npm install -g 9router
    nodejs

    # uvx --from git+https://github.com/oraios/serena serena
    # skillPython
    python313Packages.python
    uv

    # other packages
    bun
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
