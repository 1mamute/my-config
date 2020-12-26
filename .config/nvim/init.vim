" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree
Plug 'preservim/nerdtree'

" Icons for NERDTree
Plug 'ryanoasis/vim-devicons'

" Syntax Highlighting
Plug 'HerringtonDarkholme/yats.vim'

" Syntax Highlighting for NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fuzzy finder for finding files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Mouse support
set mouse+=a

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

" Visual Code Colorscheme
"colorscheme codedark

" Visual autocomplete for command menu
set wildmenu

" Highlight matching brace
set showmatch

" Nerdtree / devicons config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
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
