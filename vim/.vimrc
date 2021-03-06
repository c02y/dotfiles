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
nnoremap <Leader>fr :source ~/Dotfiles.d/vim/.vimrc<CR>

" C-z to go into shell, use exit(int shell) to go back to vim
nmap <C-Z> :shell<CR>
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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:$,space:·,conceal:·

" specll checking
set spell spelllang=en_us
set complete+=kspell
" C-x+C-l for completing the whole line, C-x+C-] for tag
" C-x+C-n for keywords in the current file, C-x+C-f for file name
" C-x+s for spelling suggestions
" check for ':h ins-completion' for more shortcuts for completion
"
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

" q to exit if no change, Q quit without saving
" NOTE: this doesn't work in `vis -v` in config.fish
" nmap q :q<CR>
" nmap Q :qa!<CR>
nmap q :q
nmap Q :qa!

set nocompatible " be iMproved, required
set number relativenumber " relative number, but hybrid one(absolute number for the current line)
" use hybrid relative in normal mode, and normal relative in insert mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
function! NumberToggle()
    if(&rnu == 1 && &nu == 1)
        set nornu nu
    elseif (&rnu == 0 && &nu ==1)
        set nonu
    elseif (&rnu == 0 && &nu == 0)
        set number
    endif
endfunction
nnoremap <Leader>tt :set number! relativenumber!<CR>
nnoremap <Leader>tn :call NumberToggle()<CR>
nnoremap <Leader>tw :set list!<CR>
nnoremap <Leader>tl :set wrap!<CR>

function! GotoClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
let $foldall=0
function ToggleFoldAll()
    if $foldall==0
        :exe "normal zM"
        let $foldall=1
    else
        :exe "normal zR"
        let $foldall=0
    endif
endfunction
" za to toggle current fold, zm to toggle all fold
" default zj/k are for GotoOpenedFold, overwrite them
nnoremap <silent> zj :call GotoClosedFold('j')<cr>
nnoremap <silent> zk :call GotoClosedFold('k')<cr>
nnoremap zm :call ToggleFoldAll()<CR>

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

noremap <C-a> <Home>
noremap <C-e> <End>
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

" normal mode, C-w c to close a window, :sp to split, :vsp ...
nnoremap <C-DOWN> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-UP> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-RIGHT> <C-W><C-L> "Ctrl-l to move right a split
nnoremap <C-LEFT> <C-W><C-H> "Ctrl-h to move left a split

nnoremap <Leader>w<LEFT> <C-W>h
nnoremap <Leader>w<RIGHT> <C-W>l
nnoremap <Leader>w<UP> <C-W>k
nnoremap <Leader>w<DOWN> <C-W>j
nnoremap <Leader>w<Bslash> <C-W>v " SPC w \ to split-window-right

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
autocmd BufRead,BufNewFile *.c,*.h set noexpandtab tabstop=8 shiftwidth=8
autocmd BufRead,BufNewFile *.cc,*.cpp set noexpandtab tabstop=4 shiftwidth=4
" NOTE: DO NOT replace the following line with second line, it is wrong
autocmd BufRead,BufNewFile *vimrc,*vim set expandtab tabstop=4 shiftwidth=4
" FIXME: expandtab will not be set using the following line
" autocmd BufRead,BufNewFile * if (&ft == "vim") | set expandtab tabstop=4 shiftwidth=4 | endif
" set foldmethod for different file types
autocmd BufRead,BufNewFile *.el set foldmethod=syntax
autocmd BufRead,BufNewFile *.py set foldmethod=indent


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

function! ToggleWindowSplit()
    if !exists('t:splitType')
        let t:splitType = 'vertical'
    endif
    if t:splitType == 'vertical' " is vertical switch to horizontal
        windo wincmd K
        let t:splitType = 'horizontal'
    else " is horizontal switch to vertical
        windo wincmd H
        let t:splitType = 'vertical'
    endif
endfunction
nnoremap <silent> <leader>wt :call ToggleWindowSplit()<cr>

" indent and jump back
nnoremap <Leader>== gg=G2<C-o>
nnoremap <Leader>={ =i{<C-o>
nnoremap <Leader>=( =i(<C-o>
nnoremap <Leader>=[ =i[<C-o>

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
" By default timeoutlen is 1000 ms
set timeoutlen=500

Plug 'scrooloose/nerdcommenter'
filetype plugin on

" unite, like Emacs's helm
Plug 'Shougo/unite.vim'
" nnoremap <leader>f :<C-u>Unite -start-insert file_rec<CR>

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"0 if you want to enable it later via :RainbowToggle

" Plug 'tpope/vim-fugitive'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"

" YCM
"Plug 'Valloric/YouCompleteMe'
" then in YouCompleteme dir: `./install.sh --clang-completer`
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
"set completeopt=menu,menuone

" jedi -- auto completion for Python
Plug 'davidhalter/jedi-vim'
let g:jedi#use_splits_not_buffers = "bottom"

Plug 'jiangmiao/auto-pairs'

Plug 'ajh17/VimCompletesMe'

Plug 'terryma/vim-multiple-cursors'

Plug 'terryma/vim-expand-region'

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
            \ call fzf#vim#files(<q-args>, {'source': 'rg --hidden --files -g !.git'}, <bang>0)
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fF :Files<Space>
nnoremap <Leader>fe :call feedkeys(":e \<Tab>", 'tn')<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>fv :e ~/Dotfiles.d/vim/.vimrc<CR>
nnoremap <Leader>pf :GFiles --cached --others<CR>
nnoremap <Leader>pF :GFiles<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>sg :Rg<CR>
nnoremap <Leader>sG :Ag<CR>

Plug 'chrisbra/NrrwRgn'

Plug 'google/vim-searchindex'

Plug 'tpope/vim-repeat'

Plug 'vim-scripts/YankRing.vim'
nnoremap <Leader>ry :YRShow<CR>
let g:yankring_min_element_length = 4
let g:yankring_manage_numbered_reg = 1

Plug 'Chiel92/vim-autoformat'
" autoformat on save
au BufWrite * :Autoformat
" disable it when the filetype is not supported or the formatter is not installed
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

Plug 'liuchengxu/vim-better-default'
" Use the following variable to 'set noexpandtab' (use tab instead of spaces)
let g:vim_better_default_tabs_as_spaces = 0
let g:vim_better_default_persistent_undo = 1
let g:vim_better_default_basic_key_mapping = 1

Plug 'matze/vim-move'
map <A-Down> <A-j>
map <A-Up>   <A-k>
map <A-Left> <A-h>
map <A-Right> <A-l>

Plug 'junegunn/vim-easy-align'
xmap <Leader>xa <Plug>(EasyAlign)
nmap <Leader>xa <Plug>(EasyAlign)

Plug 'mbbill/undotree'
nnoremap <Leader>ru :UndotreeToggle<cr>

" Put Plug parts between plug#begin() and plug #end()
" Initialize plugin system
call plug#end()
