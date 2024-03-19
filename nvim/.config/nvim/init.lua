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

local highlight = {
  "CursorColumn",
  "Whitespace",
}

require("lazy").setup({
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        plugins = {
          all = false,
          gitsigns = true,
          lsp_semantic_tokens = true,
          nvim_cmp = true,
          treesitter = true,
          telescope = true,
          indentline = true,
        }
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
  { 
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    branch = master,
    config = function()
      require("ibl").setup {
        indent = { highlight = highlight, char = "" },
        whitespace = {
            highlight = highlight,
            remove_blankline_trail = false,
        },
        scope = { enabled = false },
      }
    end
  },
  { "ryanoasis/vim-devicons", branch = "master" },
  { "nvim-tree/nvim-web-devicons", branch = "master" },
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
  { "airblade/vim-gitgutter", branch = "main" },
  { "nvim-lua/plenary.nvim", branch = "master" },
  { 
    "hrsh7th/nvim-cmp",
    branch = "main",
    config = function()
      require("cmp").setup(
        {
          sources = {
            { name = "codeium" }
          }
        }
      )
    end
  },
  { 
    "lewis6991/gitsigns.nvim",
    branch = "main",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
  },
})

vim.cmd("colorscheme onedark")


require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  };
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true;
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true;
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  };
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  };
}