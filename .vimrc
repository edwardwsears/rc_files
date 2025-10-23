set nocompatible              " be iMproved, required
filetype off                  " required for vundle (enabled at end)

set showcmd
syntax enable
syntax on

" For most common commands, use leader of space
let mapleader = "\<Space>"
"write = w
nnoremap <Leader>w :w<CR>
"write/exit = x
nnoremap <Leader>x :x<CR>
"quit = q
nnoremap <Leader>q :q!<CR>
"refresh = r
nnoremap <Leader>r :e<CR>
"tabedit = t
nnoremap <Leader>t :tabe 
"Tabcommand = c
nnoremap <Leader>c :Tabcommand 
"p4 edit file = e
nnoremap <Leader>e :!p4 edit %<CR>
"p4 diff file = d
nnoremap <Leader>d :!p4 diff %<CR>
"open taglist
nnoremap <Leader>l :TlistToggle <CR>
" Searching:
"search through nvlink dir
nnoremap <Leader>sn :Searchnvlink 
"search through nvlink lib dir
nnoremap <Leader>sl :Searchnvlinklib 
"search through nvswitch dir
nnoremap <Leader>ss :Searchswitch 
"search through manuals
nnoremap <Leader>sm :Searchmanuals 
"search through CE dir
nnoremap <Leader>sc :Searchce 
"cscope find
"s: Find this C symbol
"g: Find this definition
"d: Find functions called by this function
"c: Find functions calling this function
"t: Find this text string
"e: Find this egrep pattern
"f: Find this file
"i: Find files #including this file
"a: Find places where this symbol is assigned a value
"
" to view options, run :copen
nnoremap <Leader>f :cscope find 
"Aider question
nnoremap <Leader>a :!nvcodex aider % --edit-format ask --no-pretty <CR>

" map vimwiki <leader>ww to something else so it doesn't interfere with above
nmap <Leader>vwi <Plug>VimwikiIndex
nmap <Leader>vwdi <Plug>VimwikiDiaryIndex
nmap <Leader>vmdn <Plug>VimwikiMakeDiaryNote
nmap <Leader>vmtdn <Plug>VimwikiMakeTomorrowDiaryNote
nmap <Leader>vmydn <Plug>VimwikiMakeYesterdayDiaryNote

let g:vimwiki_list = [{
            \ 'path': '~/notes/',
            \ 'syntax': 'markdown',
            \ 'ext': 'md'
            \}]


" only show current file's taglist
let Tlist_Show_One_File = 1
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Inc_Winwidth = 1
let Tlist_WinWidth = 50 "Vertically split taglist window width.
"let Tlist_Use_Right_Window = 0
"let Tlist_Use_Horiz_Window = 0
"let Tlist_WinHeight = 20 "Horizontally split taglist window height.

" Nav reference
" gd = go to definition of local var (D for global)
" C-w T = move split to new tab

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
" %> find drivers/resman/kernel/ | grep -P ".*h|.*c" | xargs ctags --sort=1
"set ctags file
"set tags=./tags,tags
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

" Make cscope case insensitive
set csprg=cscope\ -C
cs add cscope.out
" Open cscope results in quickfix tab
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-,f-
" Automatically open quickfix tab
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
" first just display list, then try to autocomplete
set wildmenu
set wildmode=list,full

" set folding manual (set =syntax for auto)
set foldmethod=manual
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

" Turn colorscheme off for vimdiff so colors don't go crazy
if &diff
    syntax off
endif


"Create diff search command (highlight diff markers)
command! Diffsearch execute "/>>>>\\|<<<<\\|===="

"Create '-rmmsg nvlink' search command
command! Rmmsgnvlinksearch execute "/NVRM.*ioctrl\\|NVRM.*nvlink\\|NVRM.*minion\\|nvswitch.*link\\c"

"CL desc template
command! ClTemplate execute 'g/enter description here/d | -1 | r ~/.vim/templates/cldesc.template'

command! Date execute 'r !date "+\%a \%F"'

"Run shell command and display in new tab
command! -nargs=+ Tabcommand execute "tabe | r! echo \"*******************************************************************************\";echo Command: "<q-args>';echo "*******************************************************************************"\\n;'<q-args> | 1
"Generate the p4 changes of last 1000 CLs in each of the nvlink/nvswitch folders
command! ChangesNVL execute "tabe | r! p4 changes -s submitted -m 1000 drivers/resman/src/physical/gpu/nvlink/... drivers/resman/inc/physical/gpu/nvlink/... drivers/resman/inc/kernel/gpu/nvlink/... drivers/resman/src/kernel/gpu/nvlink/... drivers/nvlink/... drivers/nvswitch/..." | sort! u | 1
command! ChangesNVLr565 execute "tabe | r! p4 changes -s submitted -m 1000 //sw/rel/gpu_drv/r565/r565_00/drivers/resman/src/physical/gpu/nvlink/... //sw/rel/gpu_drv/r565/r565_00/drivers/resman/inc/physical/gpu/nvlink/... //sw/rel/gpu_drv/r565/r565_00/drivers/resman/inc/kernel/gpu/nvlink/... //sw/rel/gpu_drv/r565/r565_00/drivers/resman/src/kernel/gpu/nvlink/... //sw/rel/gpu_drv/r565/r565_00/drivers/nvlink/... //sw/rel/gpu_drv/r565/r565_00/drivers/nvswitch/..." | sort! u | 1

" Search resman nvlink folder
command! -nargs=+ Searchnvlink execute "tabe | r! "
                                        \ "echo \"*******************************************************************************\";"
                                        \ "echo Command: grep -r "<q-args>'
                                            \ drivers/resman/src/physical/gpu/nvlink/
                                            \ drivers/resman/inc/physical/gpu/nvlink/
                                            \ drivers/resman/src/kernel/gpu/nvlink/
                                            \ drivers/resman/inc/kernel/gpu/nvlink/
                                            \ drivers/resman/interface/nvRmReg.h
                                            \ drivers/resman/interface/nvrm_registry.h
                                            \ ;
                                        \ echo "*******************************************************************************"\\n;
                                        \ grep -r '<q-args>'
                                            \ drivers/resman/src/physical/gpu/nvlink/
                                            \ drivers/resman/inc/physical/gpu/nvlink/
                                            \ drivers/resman/src/kernel/gpu/nvlink/
                                            \ drivers/resman/inc/kernel/gpu/nvlink/
                                            \ drivers/resman/interface/nvRmReg.h
                                            \ drivers/resman/interface/nvrm_registry.h
                                            \ ' | 1
command! -nargs=+ Searchnvlinklib execute "tabe | r! "
                                        \ "echo \"*******************************************************************************\";"
                                        \ "echo Command: grep -r "<q-args>'
                                            \ drivers/nvlink;
                                        \ echo "*******************************************************************************"\\n;
                                        \ grep -r '<q-args>'
                                            \ drivers/nvlink
                                            \ ' | 1
command! -nargs=+ Searchswitch execute "tabe | r! "
                                        \ "echo \"*******************************************************************************\";"
                                        \ "echo Command: grep -r "<q-args>'
                                            \ drivers/nvswitch;
                                        \ echo "*******************************************************************************"\\n;
                                        \ grep -r '<q-args>'
                                            \ drivers/nvswitch' | 1
command! -nargs=+ Searchmanuals execute "tabe | r! "
                                        \ "echo \"*******************************************************************************\";"
                                        \ "echo Command: grep -r "<q-args>'
                                            \ drivers/common/inc/hwref/blackwell/gb100/;
                                        \ echo "*******************************************************************************"\\n;
                                        \ grep -r '<q-args>'
                                            \ drivers/common/inc/hwref/blackwell/gb100/' | 1
command! -nargs=+ Searchce execute "tabe | r! "
                                        \ "echo \"*******************************************************************************\";"
                                        \ "echo Command: grep -r "<q-args>'
                                            \ drivers/resman/src/physical/gpu/ce/
                                            \ drivers/resman/src/kernel/gpu/ce/
                                            \ drivers/resman/inc/physical/gpu/ce/
                                            \ drivers/resman/inc/kernel/gpu/ce/
                                            \ drivers/resman/src/physical/gpu/hshub/
                                            \ drivers/resman/inc/physical/gpu/hshub/
                                            \ ;
                                        \ echo "*******************************************************************************"\\n;
                                        \ grep -r '<q-args>'
                                            \ drivers/resman/src/physical/gpu/ce/
                                            \ drivers/resman/src/kernel/gpu/ce/
                                            \ drivers/resman/inc/physical/gpu/ce/
                                            \ drivers/resman/inc/kernel/gpu/ce/
                                            \ drivers/resman/src/physical/gpu/hshub/
                                            \ drivers/resman/inc/physical/gpu/hshub/
                                            \ ' | 1

"Format p4 file paths so can use 'gf'
command! P4filepathformat execute '%s/\/\(chips_a\/\|r\d\d\d_\d\d\/\)/\/\1 /g|%s/#/ #/g|1|/drivers/|noh'

command! Svnp01ToSv10 execute '%s/svnp01_export/nvswitch_export/gce|%s/svnp01_\(.*\)\.h/\1_sv10\.h/gce|%s/svnp01/sv10/gce|%s/SVNP01/SV10/gce'

"Remove special color characters when reading output from terminal
command! RemoveSpecialCharacters execute '%s/^[[1b\[[0-9;]*m//g | 1'

" display tabs and lines ending in spaces
set list
set listchars=tab:>-,trail:-,extends:>

" set backspace to normal behavior
set backspace=indent,eol,start

" Set yank to push to system clipboard, needs vim 7.2+
"  try =unnamedplus if having issues in linux
"set clipboard=unnamed
set clipboard=unnamed

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'ervandew/supertab'
"Plugin 'joonty/vim-do.git' " needs python support :(
Plugin 'vim-scripts/taglist.vim'
Plugin 'vimwiki/vimwiki'
"Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'vim-scripts/drawit'
" Plugin 'svermeulen/vim-yoink'
" Plugin 'AndrewRadev/linediff.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

" vim-yoink options
"nmap <c-n> <plug>(YoinkPostPasteSwapBack)
"nmap <c-p> <plug>(YoinkPostPasteSwapForward)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)
"let g:yoinkIncludeDeleteOperations = 1
"let g:yoinkSyncNumberedRegisters = 0

filetype on
