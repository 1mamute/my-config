local nvim_treesitter = {
  -- https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  build = ':TSUpdate',
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  opts = {
    ensure_installed = {
      'bash',
      'lua',
      'markdown',
      'vim',
      'vimdoc',
      'comment',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'json',
      'markdown_inline',
      'python',
      'regex',
      'requirements',
      'toml',
      'rust',
      'yaml',
      'ssh_config',
      'hcl',
      'terraform',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      -- additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
        keymaps = {
          smart_rename = "grr",
        },
      },
      navigation = {
        enable = true,
        -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    }
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Decrement selection", mode = "x" },
  },
}

local nvim_treesitter_context = {
    -- https://www.lazyvim.org/plugins/treesitter#nvim-treesitter-context
    'nvim-treesitter/nvim-treesitter-context',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function()
          local Util = require("lazyvim.util")
          local tsc = require("treesitter-context")
          tsc.toggle()
          if Util.inject.get_upvalue(tsc.toggle, "enabled") then
            Util.info("Enabled Treesitter Context", { title = "Option" })
          else
            Util.warn("Disabled Treesitter Context", { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  }

local nvim_treesitter_refactor = {
  'nvim-treesitter/nvim-treesitter-refactor',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

local plugins = {
  nvim_treesitter,
  nvim_treesitter_context,
  nvim_treesitter_refactor,
}

return plugins
