set nocompatible              " be iMproved, required
filetype off                  " required for vundle (enabled at end)

set showcmd
syntax enable
syntax on

" For most common commands, use leader of space
let mapleader = "\<Space>"
"beginning of line = h
nnoremap <Leader>h ^
"end of line = l
nnoremap <Leader>l $
"write = w
nnoremap <Leader>w :w<CR>
"write/exit = x
nnoremap <Leader>x :x<CR>
"quit = q
nnoremap <Leader>q :q!<CR>
"tabedit = t
nnoremap <Leader>t :tabe 
"Tabcommand = c
nnoremap <Leader>c :Tabcommand 
"p4 edit file = e
nnoremap <Leader>e :!p4 edit %<CR>

set tabstop=4 "for tab
set softtabstop=4 "for backspace
set expandtab "shift spaces
set shiftwidth=4
set hlsearch
set mouse=a
set ttymouse=xterm2 "Needed for mouse resize pane to work properly
set number
set autoindent

set tw=0

"set color scheme
colorscheme elflord

"change parens to yellow and bold
"hi MatchParen cterm=bold ctermbg=none ctermfg=blue

"change to bash shell
"set shell=/bin/bash

"shortcuts for buffer nav
nnoremap <C-h> gT
nnoremap <C-l> gt

"shortcuts for buffer size
nnoremap - <C-w>-
nnoremap = <C-w>+
nnoremap + <C-w>>
nnoremap _ <C-w><

" To Run Ctags:
" %> find drivers/resman/kernel/ | grep -P ".*h|.*c" | xargs ctags
"set ctags file
"set tags=~/ctags/chipsa.tags
"remove ctags & included files from tag completion (takes too long)
". = the current buffer
"w = buffers in other windows
"b = other loaded buffers
"u = unloaded buffers
"t = tags
"i = included files
"set cpt-=t
"set cpt-=i

" Setup CSCOPE
cs add cscope.out

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
" first just display list, then try to autocomplete
set wildmenu
set wildmode=list,full

" set folding on
set foldmethod=syntax
set foldcolumn=1
set foldnestmax=1

" Needs TERM="xterm-256color"
" highlight letter in 80th & 120th as width warning
if exists('+colorcolumn')
    "highlight colorcolumn ctermfg=red ctermbg=darkgrey
    "match colorcolumn "\%80v.\|\%120v."
    highlight colorcolumn ctermbg=235
    let &colorcolumn="80,120"
else
    "highlight colorcolumn ctermfg=red ctermbg=black
    "match colorcolumn "\%80v.\|\%120v."
    highlight colorcolumn ctermbg=235
    let &colorcolumn="80,120"
    "let &colorcolumn="80,".join(range(120,999),",")
endif

"Create diff search command (highlight diff markers)
command! Diffsearch execute "/>>>>\\|<<<<\\|===="

"Run shell command and display in new tab
command! -nargs=+ Tabcommand execute "tabe | r! echo \"*******************************************************************************\";echo Command: "<q-args>';echo "*******************************************************************************"\\n;'<q-args> | 1

"Format p4 file paths so can use 'gf'
command! P4filepathformat execute '%s/chips_a\//chips_a\/ /g|%s/#/ #/g|noh'

" display tabs and lines ending in spaces
set list
set listchars=tab:>-,trail:-,extends:>

" set backspace to normal behavior
set backspace=indent,eol,start

" Set yank to push to system clipboard, needs vim 7.2+
"  try =unnamedplus if having issues in linux
set clipboard=unnamed

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'ervandew/supertab'
" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
":PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype on
