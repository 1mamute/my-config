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

require("lazy").setup({
  { "neoclide/coc.nvim", branch = "release" },
  { "neoclide/coc-yaml", branch = "master" },
  { "neoclide/coc-pairs", branch = "master" },
  { "neoclide/coc-highlight", branch = "master" },
  { "neoclide/coc-git", branch = "master" },
  { "neoclide/coc-lists", branch = "master" },
  { "editorconfig/editorconfig-vim", branch = "master" },
  { "preservim/nerdtree", branch = "master" },
  { "tiagofumo/vim-nerdtree-syntax-highlight", branch = "master" },
  { "Xuyuanp/nerdtree-git-plugin", branch = "master" },
  { "ryanoasis/vim-devicons", branch = "master" },
  { "ryanoasis/vim-devicons", branch = "master" }, 
  { "airblade/vim-gitgutter", branch = "main" },
})