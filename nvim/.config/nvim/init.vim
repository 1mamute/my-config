" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" COC / Highlight / Syntax / Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-yaml', {'branch': 'master'}
Plug 'neoclide/coc-pairs', {'branch': 'master'}
Plug 'neoclide/coc-highlight', {'branch': 'master'}
Plug 'neoclide/coc-git', {'branch': 'master'}
Plug 'neoclide/coc-lists', {'branch': 'master'}
Plug 'josa42/coc-sh'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'

" Syntax Highlighting for NERDTree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
" Initialize plugin system
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

colorscheme nord                " Colorscheme
set mouse+=a                    " Mouse support
set hidden                      " TextEdit might fail if hidden is not set.
set laststatus=2                " Always display statusline
set ignorecase                  " Search case insensitive
set smartcase                   " Search case insensitive only if theres capital letters
set number                      " Line numbers
set ve+=onemore                 " Allow an extra space after end of line
set wildmenu                    " Visual autocomplete for command menu
set incsearch                   " Highlight search terms
set showmatch                   " Highlight matching brace
set cursorline
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent
set guifont=FiraCode\ Nerd\ Font\ 14
let g:nord_cursor_line_number_background=1
let g:airline_powerline_fonts = 1
syntax on

" Move lines up or down with J-K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Copy to system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
map <C-c> y
map <C-v> P

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)


" Nerdtree / devicons config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeGitStatusUseNerdFonts = 1 
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
