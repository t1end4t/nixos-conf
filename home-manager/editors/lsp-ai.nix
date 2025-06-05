{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.lsp-ai # lsp-ai for inline AI
  ];
}
