-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- The configs should run before lazy
require("config.options")
require("config.keys")

require("lazy").setup({
  checker = { enabled = true }, -- automatically check for plugin updates and provide information for lualine
  defaults = { lazy = true },   -- lazy load plugins by default
  change_detection = {
    notify = false, -- remove the notification when changes are found
  },
  spec = {
    { import = 'custom.plugins.ui' },
    { import = 'custom.plugins.git' },
    { import = 'custom.plugins.lsp' },
    { import = 'custom.plugins.file_explorer' },
    -- { import = 'custom.plugins.completions' },
    { import = 'custom.plugins.syntax_highlighting' },
    { import = 'custom.plugins.fuzzy_finder' },
  }
})
