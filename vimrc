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

" improved statusline
set laststatus=2
set statusline=%t\      "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=\ %y    "filetype
"set statusline+=%=     "left/right separator
set statusline+=\ %c,   "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
