function! myspacevim#before() abort
    " autocmd BufRead,BufNewFile *.sh,*.py syntax on
    " for python scripts with/without extension
    autocmd BufRead,BufNewFile * if (&ft == "sh") | set ts=4 sw=4 autoindent smartindent expandtab foldmethod=syntax cinwords=if,elif,else,for,while,with,try,except,finally,def,class | endif
    " for shell scripts with or without extension
    " FIXME: shell script indent is not correct when using gg=G
    autocmd BufRead,BufNewFile * if (&ft == "sh") | set noexpandtab tabstop=4 shiftwidth=4 | endif
    autocmd BufRead,BufNewFile *.fish,*.fishrc set expandtab tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.c,*.h set noexpandtab tabstop=8 shiftwidth=8
    autocmd BufRead,BufNewFile *.cc,*.cpp set noexpandtab tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile * if (&ft == "vim") | set expandtab tabstop=4 shiftwidth=4 | endif
    " set foldmethod for different file types
    autocmd BufRead,BufNewFile *.el set foldmethod=syntax

    set nomodeline " fix the error message about modeline
    " FIXME: not working
    " nnoremap <Leader>== gg=G``
    " call SpaceVim#custom#SPC('nnoremap', ['=', '='], 'echom "hello world"', 'test custom SPC', 1)

    " disable startify banner/header
    let g:startify_custom_header = []
    let g:spacevim_project_rooter_automatically = 0
    " change PWD according to the buffer, this affect a lot of functions in vim
    autocmd BufEnter * silent! lcd %:p:h

    " use airline to replace the default statusline theme
    " call SpaceVim#layers#disable('core#statusline')
    " call SpaceVim#layers#disable('core#tabline')
    " let g:spacevim_enable_powerline_fonts = 0

    " let g:spacevim_disabled_plugins = ['vim-foo', 'vim-bar']
    " let g:spacevim_custom_plugins = [
    "           \ ['vimlab/split-term.vim'],
    "           \ ]

    call SpaceVim#custom#SPCGroupName(['='], '+Formats')
    call SpaceVim#custom#SPC('nnoremap', ['=', '='], 'gg=G``', 'format-the-buffer', 0)
    call SpaceVim#custom#SPC('nnoremap', ['=', '{'], '=i{<C-o>', 'format-in-{}', 0)
    call SpaceVim#custom#SPC('nnoremap', ['=', '('], '=i(<C-o>', 'format-in-()', 0)
    call SpaceVim#custom#SPC('nnoremap', ['=', '['], '=i[<C-o>', 'format-in-[]', 0)

    call SpaceVim#custom#SPCGroupName('v', '+SPs/Terms')
    call SpaceVim#custom#SPC('nnoremap', ['v', 'u'], ':SPUpdate', 'SPUpdate', 1)
    call SpaceVim#custom#SPC('nnoremap', ['v', 'v'], ':e ~/.SpaceVim.d/autoload/myspacevim.vim', 'edit-my', 1)
    call SpaceVim#custom#SPC('nnoremap', ['v', 'V'], ':SPConfig -l', 'edit-init.toml', 1)
    " call SpaceVim#custom#SPC('nnoremap', ['v', 'r'], ':source ~/.SpaceVim.d/init.toml', 'source', 1)
    call SpaceVim#custom#SPC('nnoremap', ['v', 'l'], ':SPRuntimeLog ', 'log', 1)
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
    call SpaceVim#custom#SPCGroupName(['z'], '+Folds')
    call SpaceVim#custom#SPC('nnoremap', ['z', 'j'], ':call GotoClosedFold(\'j\')<CR>', 'next-closed-fold', 1)
    call SpaceVim#custom#SPC('nnoremap', ['z', 'k'], ':call GotoClosedFold(\'k\')<CR>', 'prev-closed-fold', 1)
    " FIXME: zm is not working
    nnoremap zm :call ToggleFoldAll()<CR>

    " call s:add_load_repo('luochen1990/rainbow')
    " let g:rainbow_active = 1

endfunction

function! myspacevim#after() abort
    let g:rainbow_active = 1
    " q to exit if no change
    nmap q :q<CR>
    nmap Q :qa!<CR>

    nnoremap <silent><Leader>m m
    nmap <Leader>== gg=G2<C-o>

    " indent and jump back
    nnoremap <Leader>== gg=G``
    nnoremap <Leader>={ =i{<C-o>
    nnoremap <Leader>=( =i(<C-o>
    nnoremap <Leader>=[ =i[<C-o>

endfunction
