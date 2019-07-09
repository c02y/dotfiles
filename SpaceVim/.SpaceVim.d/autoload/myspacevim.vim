function! myspacevim#before() abort
endfunction

function! myspacevim#after() abort
    " q to exit if no change
    nmap q :q<CR>

	nnoremap <silent><Leader>m m
    nnoremap <Leader>== gg=G2<C-o>
endfunction
