{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil # lsp for nix
    nodePackages.bash-language-server # lsp fo sh
    markdown-oxide # lsp for markdown

    # formatter
    nixfmt-rfc-style # nix formatter
    taplo # toml formatter
    deno # web-related formatter
    prettierd # other web-related formatter
  ];
}
