{ pkgs, ... }:
{
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    globalConfig.tools = {
      node = "lts";
      "npm:@anthropic-ai/claude-code" = "latest";
      "npm:@openai/codex" = "latest";
      "npm:9router" = "latest";
    };
  };

  home.packages = with pkgs; [
    # curl -fsSL https://opencode.ai/install | bash

    # uvx --from git+https://github.com/oraios/serena serena
    # skillPython
    # python314Packages.python
    # uv

    # other packages
    # bun
    # cargo
    # gcc

    # for multi-agents
    # tmux
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
