return {
  { 
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        '@yaegassy/coc-ansible',
        'coc-docker',
        'coc-pairs',
        'coc-highlight',
        'coc-git',
        'coc-lists',
        'coc-snippets',
        'coc-yaml',
        'coc-yank',
        'coc-json',
        'coc-lua',
        'coc-stylua',
        -- '@yaegassy/coc-ruff', -- já estou usando coc-pyright que vem com ruff embutido
        'coc-sh',
        'coc-pyright',
        'coc-diagnostic',
        'coc-toml',
      }
      
      vim.g.coc_filetype_map = {
        ['yaml.docker-compose'] = 'yaml',
        ['yaml.ansible'] = 'ansible'
      }
    end
  },
  { "pearofducks/ansible-vim", branch = "master" },
  { "editorconfig/editorconfig-vim", branch = "master" },
  { "tpope/vim-sleuth", branch = "master" },
}
