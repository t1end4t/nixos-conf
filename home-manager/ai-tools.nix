{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # curl -fsSL https://opencode.ai/install | bash

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
    cargo
    gcc

    # for multi-agents
    tmux
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
