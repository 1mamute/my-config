local onedarkpro = {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  lazy = false,    -- dont lazy load import ui elements
  opts = {
    plugins = {
      all = false,
      gitsigns = true,
      lsp_semantic_tokens = true,
      treesitter = true,
      telescope = true,
      indentline = true,
      which_key = true,
      neo_tree = true,
    },
    options = {
      cursorline = true,
      highlight_inactive_windows = true,
    }
  },
  config = function(_, opts)
    require("onedarkpro").setup(opts)
    vim.cmd("colorscheme onedark")
  end
}

local nvim_web_devicons = {
  "nvim-tree/nvim-web-devicons",
  branch = "master",
  config = function()
    require 'nvim-web-devicons'.setup {
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
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        }
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log"
        }
      },
    }
  end
}

local lualine = {
  -- https://www.lazyvim.org/plugins/ui#lualinenvim
  'nvim-lualine/lualine.nvim',
  branch = 'master',
  lazy = false, -- dont lazy load import ui elements
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed
        }
      end
    end

    local icons = require("utils")

    return {
      options = {
        globalstatus = true,
        refresh = {
          statusline = 100, -- faster git diff refresh
        },
      },
      extensions = {
        'neo-tree', -- add neo-tree filetype so lualine can ignore it correctly
        'lazy',     -- add lazy.nvim information in statusline
        -- 'toggleterm' -- add toggleterm filetype so lualine can ignore it correctly
      },
      sections = {
        lualine_b = {
          -- using gitsigns for branch and diff information
          -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-branch
          { 'b:gitsigns_head', icon = '' },
          {
            'diff',
            source = diff_source,
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    vim.o.laststatus = vim.g.lualine_laststatus
    require('lualine').setup(opts)
  end,
}

local bufferline = {
  -- https://www.lazyvim.org/plugins/ui#bufferlinenvim
  "akinsho/bufferline.nvim",
  lazy = false, -- dont lazy load import ui elements
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      -- https://www.lazyvim.org/plugins/editor#minibufremove
      "echasnovski/mini.bufremove",
      version = false,
      keys = {
        {
          "<leader>bd",
          function()
            local bd = require("mini.bufremove").delete
            if vim.bo.modified then
              local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
              if choice == 1 then -- Yes
                vim.cmd.write()
                bd(0)
              elseif choice == 2 then -- No
                bd(0, true)
              end
            else
              bd(0)
            end
          end,
          desc = "[b]ufferline [d]elete buffer",
        },
        -- stylua: ignore
        { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "[b]ufferline [D]elete buffer (Force)" },
      },
    },
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "[b]ufferline toggle buffer [p]in" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "[b]ufferline closes non-[P]inned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "[b]ufferline close [o]thers buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "[b]ufferline close buffers to the [r]ight" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "[b]ufferline close buffers to the [l]eft" },
    { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "prev [b]uffer" },
    { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "next [b]uffer" },
    { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "prev [b]uffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "next [b]uffer" },
  },
  opts = function()
    local bufferline = require('bufferline')

    -- sets the offset separator with the Normal highlight
    vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { link = "Normal" })

    return {
      options = {
        themable = true,
        style_preset = {
          bufferline.style_preset.no_italic,
        },
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = false,                                                       -- remove right mouse button command
        middle_mouse_command = function(n) require("mini.bufremove").delete(n, false) end, -- middle mouse delete
        always_show_bufferline = true,                                                     -- bufferline always open
        diagnostics = "coc",                                                               -- uses coc for diagnostics
        diagnostics_indicator = function(_, _, diag)
          local icons = require("utils").diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        separator_style = "thin",
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        indicator = {
          style = "underline", -- underline tab indicators
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            separator = " ", -- BufferLineOffsetSeparator
          },
        },
      },
    }
  end,
}

local gitsigns = {
  -- https://www.lazyvim.org/plugins/editor#gitsignsnvim
  -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
  "lewis6991/gitsigns.nvim",
  lazy = false, -- dont lazy load important ui elements
  branch = "main",
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '│' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    numhl = true, -- highlight changed lines numbers
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, "next [h]unk")
      map("n", "[h", gs.prev_hunk, "prev [h]unk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[g]it [h]unk [s]tage hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[g]it [h]unk [r]eset hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "[g]it [h]unks [S]tage buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "[g]it [h]unks [u]ndo stage hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "[g]it [h]unk [R]eset buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "[g]it [h]unk [p]review hunk inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "[g]it [h]unk [b]lame line")
      map("n", "<leader>ghd", gs.diffthis, "[g]it [h]unk [d]iff this")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "[g]it [h]unk [D]iff this ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}

local which_key = {
  -- https://www.lazyvim.org/plugins/editor#which-keynvim
  -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
  'folke/which-key.nvim',
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
  end,
  config = function(_, opts) -- This is the function that runs, AFTER loading
    require('which-key').setup(opts)

    -- Document existing key chains
    require('which-key').register {
      ["z"] = { name = "+fold" },
      ["g"] = { name = "+[g]oto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>b"] = { name = "+[b]uffer" },
      ["<leader>g"] = { name = "+[g]it" },
      ["<leader>gh"] = { name = "+[h]unks" },
      ["<leader>s"] = { name = "+[s]earch" },
      ["<leader>t"] = { name = "+[t]oggles" },
    }
  end,
}

local todo_comments = {
  -- https://www.lazyvim.org/plugins/editor#todo-commentsnvim
  -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = true,
  opts = { signs = false },
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "next [t]odo comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "previous [t]odo comment" },
    { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "[s]earch [t]odos" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "[s]earch [T]odos/Fix/Fixme" },
  },
}

local indent_blankline = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  branch = "master",
  dependencies = {
    "TheGLander/indent-rainbowline.nvim",
  },
  opts = function(_, opts)
    opts.indent = { char = "" }
    opts.whitespace = { highlight = { "CursorColumn", "Whitespace" }, remove_blankline_trail = false }
    opts.scope = { enabled = false }
    opts.exclude = {
      filetypes = {
        "help",
        "dashboard",
        "neo-tree",
        "lazy",
        "notify",
        "toggleterm",
        "lazyterm",
        "TelescopePrompt",
      },
    }
    return require("indent-rainbowline").make_opts(opts)
  end,
}

local plugins = {
  onedarkpro,
  nvim_web_devicons,
  lualine,
  bufferline,
  gitsigns,
  which_key,
  todo_comments,
  indent_blankline,
  -- { 'akinsho/toggleterm.nvim', version = "*", config = true },
  -- https://github.com/utilyre/barbecue.nvim (https://github.com/navarasu/onedark.nvim/blob/master/lua/barbecue/theme/onedark.lua)
  -- https://www.lazyvim.org/extras/ui/edgy
  -- https://github.com/mrjones2014/legendary.nvim
}

return plugins
