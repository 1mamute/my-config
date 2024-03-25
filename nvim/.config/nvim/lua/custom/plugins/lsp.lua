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
    }

    vim.g.coc_filetype_map = {
      ['yaml.docker-compose'] = 'yaml',
      ['yaml.ansible'] = 'ansible'
    }

    -- Bindings to move lines up and down
    vim.keymap.set('n', '<M-j>', '<cmd>m +1<CR>')
    vim.keymap.set('n', '<M-Down>', '<cmd>m +1<CR>')
    vim.keymap.set('n', '<M-k>', '<cmd>m -2<CR>')
    vim.keymap.set('n', '<M-Up>', '<cmd>m -2<CR>')

    -- Rename to F2
    vim.keymap.set('n', '<F2>', "<Plug>(coc-rename)")
    vim.keymap.set('v', '<F2>', "<Plug>(coc-rename)")

    vim.api.nvim_create_autocmd('CursorHold', {
      desc = 'Highlight symbol under cursor on CursorHold',
      pattern = "*",
      callback = function()
        vim.fn.CocActionAsync('highlight')
      end,
    })
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
  event = "VeryLazy",
  opts = {},
}

local plugins = {
  coc_nvim,
  ansible_vim,
  comment,
}

return plugins
