" .vimrc
" This file is organized by categories defined in :options

" ------------------------------------------------------------------------
" 1. important
" ------------------------------------------------------------------------

set nocompatible

" leader
let mapleader = ","

" create augroup to isolate my customizations
augroup kalrnux
    autocmd!

    " Jump to the last editing position when opening a file
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
        syntax on
        set hlsearch
    endif
augroup END

" re-hardwrap a paragraph of text
nnoremap <leader>q gqip

" join lines into one line (softwrapped paragraph)
nnoremap <leader>w vipJ0

" experimental: remap ctrl-l to deactivate search highlights
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" fix annoyances
map q: :
command -bang Q quit<bang>

" toggle spellcheck
imap <Leader>s <C-o>:setlocal spell!<CR>
nmap <Leader>s :setlocal spell!<CR>

" trigger reload of wordlister spellfile
map <leader>a :WordlisterUpdate<CR>

" ------------------------------------------------------------------------
" 3. tags
" ------------------------------------------------------------------------

set tags^=./.git/tags;

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
au kalrnux BufRead,BufNewFile *.hcl           set filetype=terraform
au kalrnux BufRead,BufNewFile *.json-dist     set filetype=json
au kalrnux BufRead,BufNewFile *.pp            set filetype=puppet
au kalrnux BufRead,BufNewFile *.txt           set filetype=text
au kalrnux BufRead,BufNewFile *.yml-dist      set filetype=yaml

" highlight listchars (trail, etc) in red
highlight SpecialKey ctermbg=196

" spellcheck language and spellfile
set spelllang=en,wordlister
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
set undodir=$HOME/.vim/undo

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
let g:airline_symbols.colnr = "\ua0"  " override broken symbol

" ------------------------------------------------------------------------
" ansible-vim plugin settings
" ------------------------------------------------------------------------
let g:ansible_unindent_after_newline = 1

" ------------------------------------------------------------------------
" vim-terraform plugin settings
" ------------------------------------------------------------------------
let g:terraform_align = 1
let g:terraform_commentstring = '#%s'

" ------------------------------------------------------------------------
" ctrlp plugin settings
" ------------------------------------------------------------------------
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ------------------------------------------------------------------------
" vim-mundo plugin settings
" ------------------------------------------------------------------------
nnoremap <F5> :MundoToggle<CR>

" ------------------------------------------------------------------------
" syntax specific settings
" ------------------------------------------------------------------------
au kalrnux syntax asciidoc syntax clear asciidocLiteralParagraph
au kalrnux syntax asciidoc syntax clear asciidocMacroAttributes

" ------------------------------------------------------------------------
" filetype specific settings
" ------------------------------------------------------------------------
au kalrnux FileType javascript setlocal shiftwidth=2 tabstop=2
au kalrnux FileType perl setlocal shiftwidth=8 tabstop=8 noexpandtab
au kalrnux FileType markdown setlocal spell nolist wrap linebreak breakat&vim nojoinspaces
au kalrnux FileType text setlocal spell nolist wrap linebreak breakat&vim nojoinspaces
