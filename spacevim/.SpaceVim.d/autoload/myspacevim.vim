function! #before() abort
    " FIXME: not working
    " q to exit if no change
    nmap q :q<CR>

	nnoremap <silent><Leader>m m
endfunction

function! myspacevim#after() abort
    " q to exit if no change
    nmap q :q<CR>
endfunction
