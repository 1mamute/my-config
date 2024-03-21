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
      'coc-stylua',
      'coc-sh',
      'coc-pyright',
      'coc-toml',
    }

    vim.g.coc_filetype_map = {
      ['yaml.docker-compose'] = 'yaml',
      ['yaml.ansible'] = 'ansible'
    }
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
