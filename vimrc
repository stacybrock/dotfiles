" pathogen
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

set nocompatible
syntax on           " turn on syntax highlighting
filetype on
filetype indent on
filetype plugin on

" map jj to escape
inoremap jj <Esc>

" fix annoyances
map q: :
command -bang Q quit<bang>

" formatting options
set tabstop=4       " set tab to four columns
set softtabstop=4   " set tab to four columns when inserting
set expandtab       " convert tabs to spaces
set shiftwidth=4    " set number of columns when reindenting
set smarttab        " insert columns equal to shiftwidth
set autoindent
set smartindent

" highlight closing brackets
set showmatch

" detect filetypes
au BufRead,BufNewFile *.pp              set filetype=puppet
au BufRead,BufNewFile *.txt             set filetype=text

" vim-airline statusline hotness
set laststatus=2
set t_Co=256
set ttimeoutlen=50
let g:airline_powerline_fonts=1

" powerline symbols
" use with Anonymous For Powerline
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" old vim-powerline symbols
" use with Droid Sans Mono Dotted for Powerline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
