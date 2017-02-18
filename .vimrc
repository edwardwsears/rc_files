 set showcmd
 syntax enable
 syntax on
 
 set tabstop=4 "for tab
 set softtabstop=4 "for backspace
 set expandtab "shift spaces
 set shiftwidth=4
 set hlsearch
 set mouse=a
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

 
 "set ctags file
 set tags=./tags
 "remove ctags & included files from tag completion (takes too long)
 ". = the current buffer
 "w = buffers in other windows
 "b = other loaded buffers
 "u = unloaded buffers
 "t = tags
 "i = included files
 set cpt-=t
 set cpt-=i
 
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
  
" highlight letter in 80th & 120th as width warning
if exists('+colorcolumn')
    match colorcolumn "\%80v.\|\%120v."
else
    highlight colorcolumn ctermbg=red
    match colorcolumn "\%80v.\|\%120v."
endif
 
 " display tabs and lines ending in spaces
 set list
 set listchars=tab:>-,trail:-,extends:>

 set nocompatible              " be iMproved, required
 filetype off                  " required
 
" Set yank to push to system clipboard, needs vim 7.2+
"  try =unnamedplus if having issues in linux
set clipboard=unnamed

 
 " VUNDLE SETUP:
 " set the runtime path to include Vundle and initialize
 " set rtp+=~/.vim/bundle/Vundle.vim
 " call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
 "call vundle#begin('~/some/path/here')
 
 " let Vundle manage Vundle, required
 "Plugin 'VundleVim/Vundle.vim'
 
 " The following are examples of different formats supported.
 " Keep Plugin commands between vundle#begin/end.
 " plugin on GitHub repo
 "Plugin 'Shougo/neocomplcache.vim'
" Plugin 'ervandew/supertab'
 " plugin from http://vim-scripts.org/vim/scripts.html
 "Plugin 'L9'
 " Git plugin not hosted on GitHub
 "Plugin 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (i.e. when working on your own plugin)
 "Plugin 'file:///home/gmarik/path/to/plugin'
 " The sparkup vim script is in a subdirectory of this repo called vim.
 " Pass the path to set the runtimepath properly.
 "Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
 " Install L9 and avoid a Naming conflict if you've already installed a
 " different version somewhere else.
 "Plugin 'ascenator/L9', {'name': 'newL9'}
 " All of your Plugins must be added before the following line
 " call vundle#end()            " required
 "filetype plugin indent on    " required
 " To ignore plugin indent changes, instead use:
 "filetype plugin on
 "
 " Brief help
 " :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just
 " :PluginUpdate
 " :PluginSearch foo - searches for foo; append `!` to refresh local cache
 " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
 "
 " see :h vundle for more details or wiki for FAQ
 " END VUNDLE SETUP
