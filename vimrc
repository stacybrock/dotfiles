" pathogen
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" turn on syntax highlighting
syntax on

" map jj to escape
inoremap jj <Esc>

" fix annoyances
map q: :

" sets your tab to four spaces
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set ai
set si

" highlight closing brackets
set showmatch

" enable some kewl vim-specific ruby stuff
" http://www.rubygarden.org/ruby?VimRubySupport
set nocompatible
filetype on
filetype indent on
filetype plugin on
compiler ruby

" detect puppet filetype
au BufRead,BufNewFile *.pp              set filetype=puppet

" detect txt files
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
