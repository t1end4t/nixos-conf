{ pkgs, ... }: {
  # Add VS Code and other editor configs here
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
      ms-python.python

      anthropic.claude-code
      openai.chatgpt
      sst-dev.opencode
    ];
  };

}
