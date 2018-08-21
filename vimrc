" .vimrc
" This file is organized by categories defined in :options

" ------------------------------------------------------------------------
" 1. important
" ------------------------------------------------------------------------

set nocompatible

" pathogen
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" leader
let mapleader = ","

" re-hardwrap a paragraph of text
nnoremap <leader>q gqip

" map jj to escape
inoremap jj <Esc>

" fix annoyances
map q: :
command -bang Q quit<bang>

" toggle spellcheck
imap <Leader>s <C-o>:setlocal spell!<CR>
nmap <Leader>s :setlocal spell!<CR>

" ------------------------------------------------------------------------
" 4. displaying text
" ------------------------------------------------------------------------

if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" ------------------------------------------------------------------------
" 5. syntax, highlighting and spelling
" ------------------------------------------------------------------------

syntax on           " turn on syntax highlighting
filetype on
filetype indent on
filetype plugin on

" detect filetypes
au BufRead,BufNewFile *.pp              set filetype=puppet
au BufRead,BufNewFile *.txt             set filetype=text

" highlight listchars (trail, etc) in red
highlight SpecialKey ctermbg=196

" spellcheck language and spellfile
set spelllang=en
set spellfile=$HOME/Dropbox/archives/vim/en.utf-8.add

" ------------------------------------------------------------------------
" 6. multiple windows
" ------------------------------------------------------------------------

set splitright
set splitbelow

" ------------------------------------------------------------------------
" 13. editing text
" ------------------------------------------------------------------------

set showmatch       " highlight closing brackets
set backspace=2     " make backspace work across inserts, newlines, etc

" ------------------------------------------------------------------------
" 14. tabs and indenting
" ------------------------------------------------------------------------

set tabstop=4       " set tab to four columns
set softtabstop=4   " set tab to four columns when inserting
set expandtab       " convert tabs to spaces
set shiftwidth=4    " set number of columns when reindenting
set smarttab        " insert columns equal to shiftwidth

" ------------------------------------------------------------------------
" 18 reading and writing files
" ------------------------------------------------------------------------

set cryptmethod=blowfish2

" ------------------------------------------------------------------------
" 20. command line editing
" ------------------------------------------------------------------------

set undofile        " save and restore undo history
set undodir=$HOME/.vimundo

" ------------------------------------------------------------------------
" 22. running make and jumping to errors
" ------------------------------------------------------------------------

set grepprg=ack | autocmd QuickFixCmdPost *grep* cwindow

" ------------------------------------------------------------------------
" statusline hotness (via vim-airline)
" ------------------------------------------------------------------------

set laststatus=2
set t_Co=256
set ttimeoutlen=50
let g:airline_powerline_fonts=1

" powerline symbols
" use with the font Anonymous for Powerline
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" old vim-powerline symbols
" use with the font Droid Sans Mono Dotted for Powerline
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
let g:airline_symbols.maxlinenr = '☰'

" ------------------------------------------------------------------------
" terraform settings
" ------------------------------------------------------------------------
let g:terraform_align=1

" ------------------------------------------------------------------------
" filetype specific settings
" ------------------------------------------------------------------------
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType terraform setlocal commentstring=#%s
autocmd FileType perl setlocal shiftwidth=8 tabstop=8 noexpandtab
