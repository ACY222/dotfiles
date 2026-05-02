" Use jk to escape insert mode
inoremap jk <esc>

" Have j and k navigate visual lines in normal mode
nnoremap <silent> <Plug>RealJ j
nnoremap <expr> j (v:count > 0) ? '<Plug>RealJ' : 'gj'
nnoremap <silent> <Plug>RealK k
nnoremap <expr> k (v:count > 0) ? '<Plug>RealK' : 'gk'

nnoremap S :w<CR>
nnoremap Q :q<CR>
nnoremap Y y$

" Use C-w, C-l to delete a word/letter in insert mode and cmd-line mode
inoremap <C-w> <esc>lcb
inoremap <C-h> <Backspace>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" find next placeholder(<++>) and edit it
nnoremap <leader><leader> /<++><CR>c4l

" change window size
nnoremap <C-h> <C-w><
nnoremap <C-j> <C-w>-
nnoremap <C-k> <C-w>+
nnoremap <C-l> <C-w>>

" shift between windows
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" shift between buffers
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bd<CR>

