local nvim_treesitter_textobjects = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

local nvim_treesitter_refactor = {
  'nvim-treesitter/nvim-treesitter-refactor',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

local nvim_treesitter_context = {
  -- https://www.lazyvim.org/plugins/treesitter#nvim-treesitter-context
  'nvim-treesitter/nvim-treesitter-context',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = { mode = "cursor", max_lines = 6 },
  keys = {
    {
      "<leader>tC",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
      end,
      desc = "[t]oggle treesitter [C]ontext",
    },
    {
      "gC",
      function()
        local tsc = require("treesitter-context")
        tsc.go_to_context(vim.v.count1)
      end,
      desc = "[g]o to [C]ontext",
    },
  },
}

local nvim_ts_context_commentstring = {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = { "VeryLazy" },
  branch = 'main',
  opts = {
    enable_autocmd = false,
  }
}

local nvim_treesitter = {
  -- https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    nvim_treesitter_textobjects,
    nvim_treesitter_refactor,
    nvim_treesitter_context,
    nvim_ts_context_commentstring,
  },
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
      'luadoc',
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
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'requirements',
      'toml',
      'rust',
      'rasi',
      'yaml',
      'ssh_config',
      'hcl',
      'terraform',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-S-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = false, --true,
      },
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = false,
        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
        keymaps = {
          smart_rename = false, --"grr",
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
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "select [a]round [f]unction" },
          ["if"] = { query = "@function.inner", desc = "select [i]nside [f]unction" },
          ["ac"] = { query = "@class.outer", desc = "select [a]round class" },
          ["ic"] = { query = "@class.inner", desc = "select [i]nside class" },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = { query = "@call.outer", desc = "next [f]unction call start" },
          ["]m"] = { query = "@function.outer", desc = "next [m]ethod/function def start" },
          ["]c"] = { query = "@class.outer", desc = "next [c]lass start" },
          ["]i"] = { query = "@conditional.outer", desc = "next cond[i]tional start" },
          ["]l"] = { query = "@loop.outer", desc = "next [l]oop start" },

          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          ["]s"] = { query = "@scope", query_group = "locals", desc = "next [s]cope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "next [f]old" },
        },
        goto_next_end = {
          ["]F"] = { query = "@call.outer", desc = "next [F]unction call end" },
          ["]M"] = { query = "@function.outer", desc = "next [M]ethod/function def end" },
          ["]C"] = { query = "@class.outer", desc = "next [C]lass end" },
          ["]I"] = { query = "@conditional.outer", desc = "next cond[I]tional end" },
          ["]L"] = { query = "@loop.outer", desc = "next [L]oop end" },
        },
        goto_previous_start = {
          ["[f"] = { query = "@call.outer", desc = "prev [f]unction call start" },
          ["[m"] = { query = "@function.outer", desc = "prev [m]ethod/function def start" },
          ["[c"] = { query = "@class.outer", desc = "prev [c]lass start" },
          ["[i"] = { query = "@conditional.outer", desc = "prev cond[i]tional start" },
          ["[l"] = { query = "@loop.outer", desc = "prev [l]oop start" },
        },
        goto_previous_end = {
          ["[F"] = { query = "@call.outer", desc = "prev [F]unction call end" },
          ["[M"] = { query = "@function.outer", desc = "prev [M]ethod/function def end" },
          ["[C"] = { query = "@class.outer", desc = "prev [C]lass end" },
          ["[I"] = { query = "@conditional.outer", desc = "prev cond[I]tional end" },
          ["[L"] = { query = "@loop.outer", desc = "prev [L]oop end" },
        },
      },
    },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)


    -- skip backwards compatible routines to speed up plugin load
    vim.g.skip_ts_context_commentstring_module = true

    -- Treesitter based folding
    -- https://github.com/nvim-treesitter/nvim-treesitter/?tab=readme-ov-file#folding
    -- https://www.reddit.com/r/neovim/comments/vaimyr/how_to_set_folding_method_permanently/
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}

local plugins = {
  nvim_treesitter,
  nvim_treesitter_context,
  nvim_treesitter_refactor,
  nvim_treesitter_textobjects,
  nvim_ts_context_commentstring,
}

return plugins
