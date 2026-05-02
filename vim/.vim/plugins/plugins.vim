call plug#begin('~/.vim/plugged')
" Open fern at the current working directory by `:Fern .`
" On a fern buffer, hit `?` to list mappings
Plug 'lambdalisue/vim-fern'
Plug 'jiangmiao/auto-pairs'
" vim themes
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'easymotion/vim-easymotion'		" move as fast as you want!
Plug 'vim-python/python-syntax', {'for': 'py'}  " python syntax highlight
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" change surround quickly
Plug 'tpope/vim-surround'
" add comments quickly
Plug 'tpope/vim-commentary'
" cpp highlight
" loaded when a file with specific file type is opened
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
" colorful parenthesis
Plug 'frazrepo/vim-rainbow'
" shows git diff in the column. it shows which lines have been added, deleted,
" modified and so on
Plug 'airblade/vim-gitgutter'
" display indent 'block'
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
call plug#end()

