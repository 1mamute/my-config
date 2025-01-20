local neo_tree = {
  -- https://www.lazyvim.org/plugins/editor#neo-treenvim
  "nvim-neo-tree/neo-tree.nvim",
  event = { "VeryLazy" },
  cmd = "Neotree",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    if vim.fn.argc(-1) == 1 then -- gets the global arguments list (-1) and check if exactly one argument was provided
      local stat = vim.loop.fs_stat(vim.fn.argv(0)) -- gets information about the file/directory that was provided
      if stat and stat.type == "directory" then
        require("neo-tree") -- loads the plugin only if it was a directory
      end
    end
  end,
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  opts = {
    close_if_last_window = true,
    enable_cursor_hijack = false, -- keep the cursor on the first letter of the filename when moving in the tree. true was bugging in #8afbb06
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Outline", "TelescopePrompt", "help" },
    enable_diagnostics = false,
    filesystem = {
      bind_to_cwd = true, -- creates a 2-way binding between vim's cwd and neo-tree's root
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,                  -- only for windows
        force_visible_in_empty_folder = true, -- hidden files will be shown if the root folder is empty
        always_show = {
          ".vscode",
          ".env",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
          ".git",
        },
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "copy path to clipboard",
        },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      name = {
        highlight_opened_files = true,
        use_git_status_colors = true,
      },
    },
    source_selector = {
      winbar = true,
      highlight_tab = "Normal",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "Normal",
      highlight_separator = "Normal",
      highlight_separator_active = "Normal",
    },
  },
  keys = {
    {
      "<C-b>",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Show File Explorer",
    },
  },
}

local vim_symlink = {
  'aymericbeaumet/vim-symlink',
  dependencies = { 'moll/vim-bbye' },
  event = { "VeryLazy" },
  lazy = false,
  cond = function()
    -- Only load the plugin if the current opened file in the buffer is a symlink
    local current_file = vim.api.nvim_buf_get_name(0)   -- Gets the path of the opened buffer file
    local stat = vim.loop.fs_lstat(current_file)        -- Gets informations about the file/link

    if stat and stat.type == "link" then
      if vim.g.debug_neovim_config then print("The opened file in the buffer is a symbolic link.") end
      return true
    else
      if vim.g.debug_neovim_config then print("The opened file in the buffer isn't a symbolic link.") end
      return false
    end
  end
}

local plugins = {
  neo_tree,
  vim_symlink,
}

return plugins
