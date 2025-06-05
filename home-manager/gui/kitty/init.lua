-- use y instead "+y
vim.keymap.set('n', 'y', '"+y', { noremap = true })
vim.keymap.set('v', 'y', '"+y', { noremap = true })
vim.keymap.set('n', 'yy', '"+yy', { noremap = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      'mikesmithgh/kitty-scrollback.nvim',
      enabled = true,
      lazy = true,
      cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
      event = { 'User KittyScrollbackLaunch' },
      -- version = '*', -- latest stable version, may have breaking changes if major version changed
      -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
      config = function()
        require('kitty-scrollback').setup()
      end,
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

