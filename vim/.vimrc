"" tips
" :bn :bp or C-^ to switch buffes

" set shell=/bin/fish

" encoding support, default utf-8
set encoding=utf8
set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1

" map SPC as leader key
let mapleader = "\<Space>"

let $MYVIMRC="$HOME/Dotfiles.d/vim/.vimrc"
" Reload vimrc without restarting vim
" Source vim configuration upon save, but it only works if editing vimrc inside vim
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
" reload vimrc manually, works when editing vimrc outside vim
nnoremap <Leader>r :source $MYVIMRC<CR>

" C-z to go into shell, use exit(int shell) to go back to vim
nmap <C-Z> :shell<CR>
nnoremap <Leader>v :e $MYVIMRC<CR>
" use right click for menu
set mousemodel=popup
set mouse=a
" nmap <silent> <leader>S :set spell!<CR>

" short
iab idate <c-r>=strftime("%H:%M:%S %Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab imail Cody Chan <cody.chan.cz@gmail.com>
iab iname Cody Chan


" no beep or slash
set vb t_vb=

" show all whitespaces, use `:set list` to show
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" use the following config to always display trailing whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/
" remove trailing whitespaces
nnoremap <Leader>bw :%s/\s\+$//e<CR>

" normal mode in GUI
nnoremap <C-DOWN> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-UP> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-RIGHT> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-LEFT> <C-W><C-H> "Ctrl-h to move left a split

" GUI client setting
if has("gui_running")
    " winpos 0 0
    set guifont=PragmataPro\ 13
    set lines=50 columns=80
    set guioptions-=T	 " toolabr
    set guioptions-=m	 " menubar
    " remove the scrollbar on left/rignt/bottom
    " cannot `set guioptions-=rlb`
    set guioptions-=r
    set guioptions-=l
    set guioptions-=b
endif
syntax on " syntax highlight
set smartindent
set autoindent

" highlight search results
set hlsearch
" no loop search
set nowrapscan
" highlight current line
set cursorline
highlight CursorLine guibg=gray
highlight Cursor guibg=NONE guifg=blue

" highlight Visual mode
highlight Visual cterm=reverse ctermbg=NONE

" q to exit if no change
" NOTE: this doesn't work in vimo function in config.fish
nmap q :q<CR>

set nocompatible " be iMproved, required
set number relativenumber " relative number, but hybrid one(absolute number for the current line)
" use hybrid relative in normal mode, and normal relative in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" toggle relativenumber and no number at all
function! NumberToggle()
  if(&rnu == 1)
    set nornu nonu
  else
    set number relativenumber
  endif
endfunc
nnoremap <C-l> :call NumberToggle()<cr>
function! ListToggle()
    if(&list == 1)
        set nolist
    else
        set list
    end
endfunc
nnoremap <C-S-l> :call ListToggle()<cr>
set showcmd		 " show command
autocmd BufEnter * :syntax sync fromstart
set backspace=eol,start,indent
set incsearch
set ignorecase	 " ignore case when searching
set smartcase
set magic		 " :h magic
set showmatch	 " paren
set nobackup
set nowb		 " backup before overwriting
set swapfile	 " use .swap file to recover
set linebreak
set wildmenu	 " Tab to show command completion list
set wildmode=list:longest,list:full
set wildignore=.git,*.swp,*/tmp/*
set history=400	 " remember the history of commands
set autoread	 " auto reload when file is modified from outside
set omnifunc=syntaxcomplete#Complete
set shiftwidth=4
set tabstop=4

set pastetoggle=<F9>	 " paste from out-program under insert mode
" donnot have to type F9 before pasting from outside of Vim
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"""""""""""""""""""" statusline""""""""""""""""""""""""""""""
set laststatus=2 " always show status line
highlight StatusLine cterm=bold ctermfg=black ctermbg=white
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "KB"
    endif
endfunction
function! ShowFileFormatFlag(var)
  if ( a:var == 'dos' )
    return '[dos]'
  elseif ( a:var == 'mac' )
    return '[mac]'
  else
    return ''
  endif
endfunction
set statusline=[%n]%1*%{ShowFileFormatFlag(&fileformat)}%*\ %f%m%r%h\ \|\ %{CurDir()}\ \|\ \|\ (%l,%v)(%p%%)%{FileSize()}\ \|\ %{&fileencoding?&fileencoding:&encoding}\ \|
"set statusline=[%n]\ %f%m%r%h\ \|\ %{CurDir()}\ \|\ \|(%l,%c)(%p%%)%{FileSize()}\|\ %{((&fenc==\"\")?\"\":\"\".&fenc)}\ \|
"""""""""""""""""""""""""""""""""""""""""""""""""""

" searches forward/backward using */#
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" C-J/K to switch buffers
nn <C-J> :bn<cr>
nn <C-K> :bp<cr>

noremap <C-a> <Home>
noremap <C-e> <End>
imap <C-a> <Home>
imap <C-e> <End>              " FIXME: this doesn't work
imap <C-k> <c-o>d$

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" emacs commands in insert mode
" ctrl-b/f
imap <C-b> <Left>
imap <C-f> <Right>

" alt-b/f
" note the alt-b is generate by ctr-v then press alt-b ...
imap ^[b   <S-Left>
imap ^[f   <S-Right>

imap <C-d> <Del>
imap <C-h> <BS>
imap ^[d   <c-o>de
imap <C-w> <c-o>db
imap <C-u> <c-o>d^

imap <C-b> <Left>
imap <C-f> <Right>
imap ^[b <S-Left>
imap ^[f <S-Right>
imap <C-d> <Del>
imap <C-h> <BS>
imap ^[d <c-i>de
imap <C-w> <c-o>db
imap <C-u> <c-o>d^
"imap <M-b> bi
"imap <M-f> wi

" Needed for tmux and vim to play nice when using A-array keys
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" move current line up/down, and indent
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" normal mode, C-w c to close a window, :sp to split, :vsp ...
nnoremap <C-DOWN> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-UP> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-RIGHT> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-LEFT> <C-W><C-H> "Ctrl-h to move left a split

" M-Backspace to delete word in insert-mode, this following does not work in terminal vim
imap <A-BS> <C-W>

" restore the position when opening again
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" bash indent "case"
let g:sh_indent_case_labels=1

" start insert when editing git commit message
au FileType gitcommit 1 | startinsert

" change PWD according to the buffer, this affect a lot of functions in vim
autocmd BufEnter * silent! lcd %:p:h

" turn pyton syntax on
"syntax on
"autocmd BufRead,BufNewFile *.sh,*.py syntax on
autocmd BufRead,BufNewFile *.py set ts=4 sw=4 autoindent smartindent expandtab cinwords=if,elif,else,for,while,with,try,except,finally,def,class
autocmd BufRead,BufNewFile *.sh set expandtab tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.fish,*.fishrc set expandtab tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.c,*.cpp set noexpandtab tabstop=8 shiftwidth=8

" this fix the errors(like Error detected while processing function) when using VundleInstall/Update
set shell=/bin/bash

"""""""""""""""""" junegunn/vim-plug: plugins manager """"""""""""""""""
" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/autoload')

nnoremap <Leader>vi :PlugInstall<CR>
nnoremap <Leader>vc :PlugClean<CR>
nnoremap <Leader>vC :PlugClean!<CR>
nnoremap <Leader>vu :PlugUpdate<CR>
nnoremap <Leader>vU :PlugUpgrade<CR>

" indent and jump back
nnoremap <Leader>== gg=G2<C-o>
nnoremap <Leader>={ =i{<C-o>
nnoremap <Leader>=( =i(<C-o>
nnoremap <Leader>=[ =i[<C-o>

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
" By default timeoutlen is 1000 ms
set timeoutlen=500

" nerdcommenter
Plug 'scrooloose/nerdcommenter'
filetype plugin on

" unite, like Emacs's helm
Plug 'Shougo/unite.vim'
" nnoremap <leader>f :<C-u>Unite -start-insert file_rec<CR>

" rainbow parentheses
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"0 if you want to enable it later via :RainbowToggle

" Plug 'tpope/vim-fugitive'

" ultisnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"

" YCM
"Plug 'Valloric/YouCompleteMe'
" then in YouCompleteme dir: `./install.sh --clang-completer`
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
"set completeopt=menu,menuone

" vim-swoop
Plug 'pelodelfuego/vim-swoop'
" Swoop current buffer
" use the better default bindings <Leader>l, ml
"nmap <C-s> :call Swoop()<CR>
"vmap <C-s> :call SwoopSelection()<CR>
" Swoop multi buffers
"nmap <C-S-s> :call SwoopMulti()<CR>
"vmap <C-S-s> :call SwoopMultiSelection()<CR>
let g:defaultWinSwoopWidth = 60
let g:defaultWinSwoopHeight = 12
nmap <Leader>ss :call Swoop()<CR>
nmap <Leader>sS :call SwoopSelection()<CR>
nmap <Leader>sm :let g:swoopWindowsVerticalLayout = 1<CR>
nmap <Leader>sn :let g:swoopWindowsVerticalLayout = 0<CR>

" jedi -- auto completion for Python
Plug 'davidhalter/jedi-vim'
let g:jedi#use_splits_not_buffers = "bottom"

" auto-pairs
Plug 'jiangmiao/auto-pairs'

" AutoComplPop
Plug 'vim-scripts/AutoComplPop'

" vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

" vim-expand-region
Plug 'terryma/vim-expand-region'

" python-mode
Plug 'klen/python-mode'
"default is python2
"let g:pymode_python = 'python3'
let g:pymode_options_colorcolumn = 0

Plug 'wellle/targets.vim'

Plug 'tpope/vim-commentary'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_modified = '!'

Plug 'tpope/vim-unimpaired'

" need ~/.fzf + fzf-binary + fzf.vim to work
" silently git clone the fzf repo
silent !git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'
" Overwrite the default Files command to include hidden files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fF :Files<Space>
nnoremap <Leader>fe :call feedkeys(":e \<Tab>", 'tn')<CR>
nnoremap <Leader>fv :e ~/Dotfiles.d/vim/.vimrc<CR>
nnoremap <Leader>pf :GFiles --cached --others<CR>
nnoremap <Leader>pF :GFiles<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>sg :Ag<CR>
nnoremap <Leader>sG :Rg<CR>

Plug 'chrisbra/NrrwRgn'

Plug 'google/vim-searchindex'

Plug 'tpope/vim-repeat'

Plug 'vim-scripts/YankRing.vim'
nnoremap <Leader>ry :YRShow<CR>
let g:yankring_min_element_length = 4
let g:yankring_manage_numbered_reg = 1


" Put Plug parts between plug#begin() and plug #end()
" Initialize plugin system
call plug#end()
