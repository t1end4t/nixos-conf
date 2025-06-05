{ kitty-scrollback-nvim, ... }:
let
  kitty_config = builtins.readFile ./kitty.conf;
  nvim_config = builtins.readFile ./init.lua;
in
{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      ${kitty_config}
    '';
  };

  # https://github.com/mikesmithgh/kitty-scrollback.nvim#%EF%B8%8F-setup
  home.file.".config/kitty/kitty_scrollback_nvim.py" = {
    source = "${kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
  };

  #NOTE: use nvim because kitty don't have built-in vi-mode
  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
      ${nvim_config}
    '';
  };

}
