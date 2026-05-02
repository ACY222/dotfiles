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

" coc.nvim settings
" Use <CR> to accept selected completion item
" Use tab, S-tab to select next, previous completion
" Use <C-a> to trigger completion
inoremap <expr><C-n> coc#pum#visible() ? coc#pum#next(1) :
      \ coc#refresh()
inoremap <expr><C-p> coc#pum#visible() ? coc#pum#prev(1) :
      \ coc#refresh()
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() :
      \ coc#refresh()

" CheckBackspace
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use ' -' and ' =' to navigate diagnostics
" ' a' to show all diagnostics
nnoremap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>= <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>a :<C-u>CocList diagnostics<CR>
" Goto code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
" Use D to show documentation in preview window
nnoremap <silent> <leader>d :call ShowDocumentation()<CR>
function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction
" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)
" Applying codeAction to the selected region
" Maybe I need some plugins to use these two lines
function! CocActionOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xnoremap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' .visualmode()<CR>
nnoremap <silent> <leader>a :<C-u>set operatorfunc=<SID>CocActionOpenFromSelected<CR>g@


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

