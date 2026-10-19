{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "codex-run";
      runtimeInputs = [
        tmux
        zellij
        coreutils
        jq
        util-linux
      ];
      text = builtins.readFile ../scripts/codex-run.sh;
    })

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
    cargo
    gcc

    # for multi-agents
    tmux
  ];

  home.activation.agentPanes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.python3}/bin/python ${../scripts/setup-agent-panes.py} \
      ${lib.escapeShellArg "${pkgs.python3}/bin/python ${../scripts/claude-pane.py}"}
  '';

  # remember login
  services.gnome-keyring.enable = true;
}
