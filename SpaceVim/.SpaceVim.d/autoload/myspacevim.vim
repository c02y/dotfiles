function! myspacevim#before() abort
  " autocmd BufRead,BufNewFile *.sh,*.py syntax on
  autocmd BufRead,BufNewFile *.py set ts=4 sw=4 autoindent smartindent expandtab cinwords=if,elif,else,for,while,with,try,except,finally,def,class
  autocmd BufRead,BufNewFile *.sh set expandtab tabstop=4 shiftwidth=4
  autocmd BufRead,BufNewFile *.fish,*.fishrc set expandtab tabstop=4 shiftwidth=4
  autocmd BufRead,BufNewFile *.c,*.cpp set noexpandtab tabstop=8 shiftwidth=8

  " FIXME: not working
  " nnoremap <Leader>== gg=G``
  " call SpaceVim#custom#SPC('nnoremap', ['=', '='], 'echom "hello world"', 'test custom SPC', 1)
endfunction

function! myspacevim#after() abort
    " q to exit if no change
    nmap q :q<CR>

	nnoremap <silent><Leader>m m
    nmap <Leader>== gg=G2<C-o>

    " cscope
    autocmd BufNewFile,BufRead *.c,*.h,*.hpp,*.cpp,*.cc call spacevim#vim#cscope#Build()
    autocmd BufNewFile,BufWritePost *.c,*.h,*.hpp,*.cpp,*.cc call spacevim#vim#cscope#UpdateDB()

endfunction
