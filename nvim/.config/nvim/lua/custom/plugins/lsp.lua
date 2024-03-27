local coc_nvim = {
  "neoclide/coc.nvim",
  branch = "release",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    vim.g.coc_global_extensions = {
      '@yaegassy/coc-ansible',
      'coc-docker',
      'coc-pairs',
      'coc-highlight',
      'coc-lists',
      'coc-snippets',
      'coc-ultisnips',
      'coc-yaml',
      'coc-yank',
      'coc-json',
      'coc-lua',
      'coc-sh',
      'coc-pyright',
      'coc-toml',
      'coc-lightbulb',
      'coc-symbol-line',
    }

    -- Bindings to move lines up and down
    vim.keymap.set('n', '<M-j>', '<cmd>m +1<CR>', { noremap = true, desc = 'Move One Line Down' })
    vim.keymap.set('n', '<M-Down>', '<cmd>m +1<CR>', { noremap = true, desc = 'Move One Line Down' })
    vim.keymap.set('n', '<M-k>', '<cmd>m -2<CR>', { noremap = true, desc = 'Move One Line Up' })
    vim.keymap.set('n', '<M-Up>', '<cmd>m -2<CR>', { noremap = true, desc = 'Move One Line Up' })

    -- Rename to F2
    vim.keymap.set('n', '<F2>', "<Plug>(coc-rename)", { noremap = true, desc = 'Rename Symbol' })
    vim.keymap.set('v', '<F2>', "<Plug>(coc-rename)", { noremap = true, desc = 'Rename Symbol' })

    -- Format to Ctrl + Shift + I
    vim.keymap.set('n', '<C-S-I>', "<Plug>(coc-format)", { noremap = true, desc = 'Format Document' })




    -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
    vim.api.nvim_create_augroup("CocGroup", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold"
    })

    -- To fix the highlight of comment
    vim.api.nvim_create_autocmd("FileType", {
      group = "CocGroup",
      pattern = "json",
      desc = "Fix highlight of comments in JSON files",
      callback = function()
        vim.cmd [[syntax match Comment +\/\/.\+$+]]
      end,
    })
    -- Update signature help on jump placeholder
    vim.api.nvim_create_autocmd("User", {
      group = "CocGroup",
      pattern = "CocJumpPlaceholder",
      command = "call CocActionAsync('showSignatureHelp')",
      desc = "Update signature help on jump placeholder"
    })

    -- Show symbol documentation on CursorHold
    -- Define o autocommand usando Lua
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('doHover')",
      desc = "Show documentation for symbol under cursor on CursorHold"
    })

    -- show symbol line on winbar (bufferline.nvim)
    function _G.symbol_line()
      local curwin = vim.g.statusline_winid or 0
      local curbuf = vim.api.nvim_win_get_buf(curwin)
      local ok, line = pcall(vim.api.nvim_buf_get_var, curbuf, 'coc_symbol_line')
      return ok and line or ''
    end

    vim.o.winbar = '%!v:lua.symbol_line()'

    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      { silent = true, noremap = true, expr = true, replace_keycodes = false })

    -- Use <Tab> and <S-Tab> to navigate the completion list:
    vim.keymap.set('i', '<Tab>', [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]],
      { expr = true, noremap = true, silent = true })
    vim.keymap.set('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"]],
      { expr = true, noremap = true, silent = true })

    -- Use <c-j> to trigger snippets
    vim.keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

    -- Use <c-space> to trigger completion
    vim.keymap.set("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- Use `[d` and `]d` to navigate diagnostics
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
    vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- GoTo code navigation
    vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
    vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
    vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
  end
}

local ansible_vim = {
  "pearofducks/ansible-vim",
  branch = "master",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  ft = { "yaml.ansible" },
}

local comment = {
  'numToStr/Comment.nvim',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  opts = {
 --   pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  },
}

local vim_snippets = {
  'honza/vim-snippets',
  event = { "VeryLazy" },
  dependencies = "neoclide/coc.nvim",
}

local plugins = {
  coc_nvim,
  ansible_vim,
  comment,
  vim_snippets,
}

return plugins
