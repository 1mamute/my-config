local telescope_fzf_native = {
  -- If encountering errors, see telescope-fzf-native README for installation instructions
  'nvim-telescope/telescope-fzf-native.nvim',

  -- `build` is used to run some command when the plugin is installed/updated.
  -- This is only run then, not every time Neovim starts up.
  build = 'make',

  -- `cond` is a condition used to determine whether this plugin should be
  -- installed and loaded.
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
}

local telescope_coc = {
  'fannheyward/telescope-coc.nvim',
  event = 'VeryLazy',
}

local telescope = {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    telescope_fzf_native,
    telescope_coc,
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
    'tsakirist/telescope-lazy.nvim',
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          find_command = {
            'rg',
            '--files',
            '--hidden', -- show hidden files
            '--follow', -- follow symlink
            '-g',
            '!.git' -- ignore .git folder
          },
        },
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- show hidden files
          "--follow", -- follow symlink
          "--trim"    -- ripgrep remove indentation
        },
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = { ['<c-enter>'] = 'to_fuzzy_refine', ["<esc>"] = require('telescope.actions').close },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        coc = {
          prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        },
        lazy = {
          -- Whether or not to show the icon in the first column
          show_icon = true,
          mappings = {
            open_in_browser = "<C-o>",
            open_in_file_browser = "<M-b>",
            open_in_find_files = "<C-f>",
            open_in_live_grep = "<C-g>",
            open_in_terminal = "<C-t>",
            open_plugins_picker = "<C-b>", -- Works only after having called first another action
            open_lazy_root_find_files = "<C-r>f",
            open_lazy_root_live_grep = "<C-r>g",
            change_cwd_to_plugin = "<C-c>d",
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'coc')
    pcall(require('telescope').load_extension, 'lazy')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sH', builtin.highlights, { desc = '[s]earch [H]ighlights' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[s]earch [b]uffers' })
    vim.keymap.set('n', '<leader>sC', builtin.command_history, { desc = '[s]earch recent [C]ommands' })
    vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[s]earch [c]ommands' })
    vim.keymap.set('n', '<leader>sl', "<cmd>Telescope lazy<CR>", { desc = '[s]earch [l]azy.nvim plugins' })
    vim.keymap.set('n', 'gw', "<cmd>Telescope coc workspace_symbols<CR>", { desc = '[g]o to [w]orkspace symbols' })
    vim.keymap.set('n', 'gd', "<cmd>Telescope coc document_symbols<CR>", { desc = '[g]o to [d]ocument symbols' })

    local coc_references = function()
      require('telescope').extensions.coc.references({
        layout_strategy = 'horizontal',
        layout_config = {
          width = 0.9,
          height = 0.3,
          mirror = true
        }
      })
    end

    vim.keymap.set('n', 'gr', coc_references, { desc = '[g]o to [r]eferences' })

    -- Find references to Shift - F12 like VSCode
    vim.keymap.set('n', '<F24>', coc_references, { desc = 'Find References' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = true,
      })
    end, { desc = '[/] search in current buffer' })

    -- Find files from project git root with fallback
    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#find-files-from-project-git-root-with-fallback
    vim.keymap.set('n', '<leader>sf', function()
      local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
      end
      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
      end
      local opts = {}
      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
        }
      end
      require("telescope.builtin").find_files(opts)
    end, { desc = '[s]earch [f]iles' })


    -- Live grep from project git root with fallback
    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#live-grep-from-project-git-root-with-fallback
    vim.keymap.set('n', '<leader>sg', function()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")

          return vim.v.shell_error == 0
        end

        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local opts = {}

        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end

        require("telescope.builtin").live_grep(opts)
      end,
      { desc = '[s]earch by [g]rep' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[s]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[s]earch [n]eovim files' })
  end,
}

local plugins = {
  telescope,
}

return plugins
