{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # lsp for nix
    nixd # other lsp for nix (zed editor)
    bash-language-server # lsp fo sh
    markdown-oxide # lsp for markdown

    # formatter
    nixfmt # nix formatter
    taplo # toml formatter
    deno # web-related formatter
    prettierd # other web-related formatter

    # additional packages
    pyright
    ruff
  ];
}
