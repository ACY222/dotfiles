" Compile and run quickly based on filetype
augroup QuickRun
    autocmd!
    autocmd FileType cpp command! -buffer CompileAndRun write <bar> !g++ -std=c++20 % -o %< && ./%<
    autocmd FileType c   command! -buffer CompileAndRun write <bar> !gcc % -o %< && ./%<
    autocmd FileType python command! -buffer CompileAndRun write <bar> !python3 %
augroup END

" Compile to debug
augroup QuickCompile
    autocmd!
    autocmd FileType cpp command! -buffer CompileToDebug write <bar> !g++ -std=c++20 -g % -o %<
    autocmd FileType c   command! -buffer CompileToDebug write <bar> !gcc -g % -o %<
augroup END

" Vim config shortcuts
augroup VimConfig
    autocmd!
    autocmd FileType vim nnoremap <buffer> <leader>sv :w<CR>:source $MYVIMRC<CR>
    autocmd FileType vim nnoremap <buffer> <leader>in :PlugInstall<CR>
    autocmd FileType vim nnoremap <buffer> <leader>cl :PlugClean<CR>
augroup END

" stay where you were when you left last time
augroup RestoreCursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
