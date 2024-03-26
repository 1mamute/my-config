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

    vim.api.nvim_create_autocmd('CursorHold', {
      desc = 'Highlight symbol under cursor on CursorHold',
      pattern = "*",
      callback = function()
        vim.fn.CocActionAsync('highlight')
      end,
    })

    -- show symbol line on winbar (bufferline.nvim)
    function _G.symbol_line()
      local curwin = vim.g.statusline_winid or 0
      local curbuf = vim.api.nvim_win_get_buf(curwin)
      local ok, line = pcall(vim.api.nvim_buf_get_var, curbuf, 'coc_symbol_line')
      return ok and line or ''
    end

    vim.o.winbar = '%!v:lua.symbol_line()'
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
  opts = {},
}

local plugins = {
  coc_nvim,
  ansible_vim,
  comment,
}

return plugins
