" airline, catppuccin settings
let g:lightline = {
      \ 'colorscheme': 'catppuccin_mocha',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
let g:lightline#bufferline#show_number = 2

colorscheme catppuccin_mocha

" easymotion settings
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
" based on word
nnoremap <leader>w <Plug>(easymotion-bd-w)

" auto-pairs settings
let g:AutoPairsMapBS = 0
let g:AutoPairsMapSpace = 0

augroup CustomFileTypePairs
    autocmd!

    autocmd FileType vim
        \ let b:AutoPairs = {'(':')', '[':']', '<':'>', '{':'}', "'":"'", '`':'`'}
augroup END

" asyncomplete.vim
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : asyncomplete#force_refresh()
inoremap <expr> <C-p> pumvisible() ? "\<C-p>" : asyncomplete#force_refresh()
inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>h <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" vim-rainbow settings
let g:rainbow_active = 1


" vim-gitgutter settings
" jump between hunks(hunk: a contiguous block of changes between two versions)
nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)


" python highlight
let g:python_highlight_all = 1

" yank highlight
let g:highlightedyank_highlight_duration = 200

