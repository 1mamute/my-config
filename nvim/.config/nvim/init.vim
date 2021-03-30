" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" COC / Highlight / Syntax / Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-yaml', {'branch': 'master'}
Plug 'neoclide/coc-pairs', {'branch': 'master'}
Plug 'neoclide/coc-tabnine', {'branch': 'master'}
Plug 'neoclide/coc-snippets', {'branch': 'master'}
Plug 'neoclide/coc-highlight', {'branch': 'master'}
Plug 'neoclide/coc-git', {'branch': 'master'}
Plug 'antoinemadec/coc-fzf'
Plug 'neoclide/coc-eslint', {'branch': 'master'}
Plug 'neoclide/coc-emmet', {'branch': 'master'}
Plug 'antonk52/coc-cssmodules', {'branch': 'master'}
Plug 'neoclide/coc-tsserver', {'branch': 'master'}
Plug 'neoclide/coc-prettier', {'branch': 'master'}
Plug 'neoclide/coc-git', {'branch': 'master'}
Plug 'josa42/coc-sh'
Plug 'neoclide/coc-lists', {'branch': 'master'}
Plug 'fannheyward/coc-pyright', {'branch': 'master'}
Plug 'fannheyward/coc-markdownlint', {'branch': 'master'}
Plug 'neoclide/coc-json', {'branch': 'master'}
Plug 'neoclide/coc-html', {'branch': 'master'}
Plug 'neoclide/coc-css', {'branch': 'master'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ekalinin/dockerfile.vim'
Plug 'pangloss/vim-javascript'
Plug 'hashivim/vim-terraform'
Plug 'mitchellh/vagrant'
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'

" Statusline
Plug 'liuchengxu/eleline.vim'

" Commentary
Plug 'tpope/vim-commentary'

" Syntax Highlighting for NERDTree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fuzzy finder for finding files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Mouse support
set mouse+=a

" TextEdit might fail if hidden is not set.
set hidden

" Always display statusline
set laststatus=2

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Highlight search terms
set incsearch

" Search case insensitive
set ignorecase

" Search case insensitive only if theres capital letters
set smartcase

" Encoding
set encoding=UTF-8

" Line numbers
set number

" Allow an extra space after end of line
set ve+=onemore

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Backspace in insert mode
set backspace=indent,eol,start

" Column for line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Space and tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

" Syntax
syntax on

" Copy to system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
map <C-c> y
map <C-v> P

" Visual autocomplete for command menu
set wildmenu

" Highlight matching brace
set showmatch

" Nerdtree / devicons config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" FZF config
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
