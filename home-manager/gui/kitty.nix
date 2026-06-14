{ pkgs, ... }: {
  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      shell = "${pkgs.zellij}/bin/zellij";
      allow_remote_control = "socket-only";
      listen_on = "unix:@mykitty";
      window_padding_width = 6;
    };

    extraConfig = ''
      exe_search_path ${pkgs.kitty}/bin
      exe_search_path ${pkgs.neovim}/bin
      action_alias kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py
      map ctrl+shift+space kitty_scrollback_nvim --nvim-args --cmd "set runtimepath+=${pkgs.vimPlugins.kitty-scrollback-nvim}" --cmd "set clipboard+=unnamedplus" --cmd "lua require('kitty-scrollback').setup({ paste_window = { yank_register_enabled = false } })"
    '';
  };
}
