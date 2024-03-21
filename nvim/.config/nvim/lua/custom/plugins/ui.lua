local onedarkpro = {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  lazy = false, -- dont lazy load import ui elements
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
      -- nvim_cmp = true,
      -- trouble = true,
    }
  },
  config = function()
    vim.cmd("colorscheme onedark")
  end
}

local nvim_web_devicons = {
  "nvim-tree/nvim-web-devicons",
  branch = "master",
  config = function()
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

    return {
      options = {
        sections = {
          lualine_b = {
            {
              -- using gitsigns for branch and diff information
              -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-branch
              {'b:gitsigns_head', icon = ''},
              { 'diff', source = diff_source },
              'diagnostics',
            },
          },
        },
        globalstatus = true,
        refresh = {
          statusline = 100, -- faster git diff refresh
        },
        extensions = {
          'neo-tree', -- add neo-tree filetype so lualine can ignore it correctly
          -- 'trouble' -- trouble mode information
          -- 'toggleterm' -- add toggleterm filetype so lualine can ignore it correctly
          -- 'lazy', -- add lazy.nvim information in statusline
        },
      }
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
          desc = "Delete Buffer",
        },
        -- stylua: ignore
        { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
      },
    },
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = {
    options = {
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      right_mouse_command = false, -- remove right mouse button command
      middle_mouse_command = function(n) require("mini.bufremove").delete(n, false) end, -- middle mouse delete
      always_show_bufferline = true, -- bufferline always open
      diagnostics = "coc", -- uses coc for diagnostics
      separator_style = "padded_slant",
      indicator = {
        style = "underline", -- underline tab indicators
      },
      show_buffer_icons = false, -- disable filetype icons
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          -- highlight = "Directory",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
  config = function(_, opts)
    -- já é configurado pelo tema onedarkpro mas vamos setar denovo para garantir
    vim.opt.termguicolors = true

    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    -- vim.api.nvim_create_autocmd("BufAdd", {
    --   callback = function()
    --     vim.schedule(function()
    --       pcall(nvim_bufferline)
    --     end)
    --   end,
    -- })
  end,
}

local gitsigns = {
  -- https://www.lazyvim.org/plugins/editor#gitsignsnvim
  -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
  "lewis6991/gitsigns.nvim",
  lazy = false, -- dont lazy load import ui elements
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
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
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
    vim.o.timeoutlen = 300
  end,
  config = true
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
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}

local trouble = {  
  -- https://www.lazyvim.org/plugins/editor#troublenvim
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}

local indent_blankline = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  branch = master,
  dependencies = {
    "TheGLander/indent-rainbowline.nvim",
  },
  opts = function(_, opts)
    opts.indent = { char = "" }
    opts.whitespace = { highlight = { "CursorColumn", "Whitespace" }, remove_blankline_trail = false }
    opts.scope = { enabled = false }
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
  -- trouble,
  -- { 'akinsho/toggleterm.nvim', version = "*", config = true },
  -- https://github.com/utilyre/barbecue.nvim (https://github.com/navarasu/onedark.nvim/blob/master/lua/barbecue/theme/onedark.lua)
  -- https://www.lazyvim.org/extras/ui/edgy 
}

return plugins