" ---------- leader ----------
let mapleader=" "
let maplocalleader=","


" ---------- base config ----------
set nocompatible            " not vi compatible
filetype on                 " enable file type detection
filetype indent on          " use corresponding indent
filetype plugin on          " set load plugin by file type

" If this many ms nothing is typed the swap file will be written to disk
set updatetime=100          
" timeout on :mappings 
set timeoutlen=500    
set mouse+=a                " Enable mouse support
set clipboard=unnamed       " use system clipboard

" cache and undo history
set nobackup                " don't create backup file
set nowritebackup           " No backup made
set noswapfile              " don't create temp file
set undofile                " create undo file
set undodir=~/.vim/.undo//
set history=50              " record 50 operations

set autochdir               " change directory when open a new file
set autoread                " when editing files are changed in other place
set hidden                  " enable to hidden buffers without saving
set wildmenu                " wildchar is <TAB> by default
set wildmode=longest,list

" encoding
set langmenu=zh_CN.UTF-8    " set language menu encode utf8
set helplang=cn             " set helping language Chinese


" ---------- ui config ----------
set noerrorbells visualbell t_vb=   " Disable audible bell
set shortmess+=sI           " Disable the default Vim startup message
set noshowmode              " don't show mode (insert/normal) at the bottom
set showcmd                 " display inputting commands

" window layout
set splitbelow              " open new split panes to bottom
set splitright              " open new split panes to right


set number                  " enable line number
set relativenumber          " relative line number
set signcolumn=yes          " Always show the signcolumn to prevent shifting
set showtabline=2
set laststatus=2            " always show the status line at the bottom

" color and highlight
syntax enable               " highlight enable
syntax on                   " highlight auto
set t_Co=256                " use 256 colors
set termguicolors
set cursorline              " highlight current line
set showmatch               " highlight matching brackets
set matchtime=1

" cursor looks
set guicursor=n-v-r:block,i-c-ci:ver25  
let &t_ti .= "\e[2 q"       " Terminal block cursor on enter
let &t_te .= "\e[0 q"       " Terminal default cursor on exit

" background
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE


" ---------- edit config ----------
set backspace=indent,eol,start  " allow backspacing over everything
set whichwrap+=h,l          " set the cursor keys across rows
set matchpairs+=<:>         " allow % jump between <>

" indents and tabs
set autoindent              " copy indent from current line
set tabstop=4               " the size of tab
set expandtab               " replace tab with spaces
set softtabstop=4           " 1 tab == 4 spaces
set shiftwidth=4            " shift size when using '<<' or '>>'
set shiftround              " round indent to multiple of 4

" format and folds
set textwidth=80            " the width of each line
set wrap                    " break lines automatically
set linebreak               " break only when encountering with specific character
set scrolloff=5             " keep 5 lines above/below cursor
set foldlevelstart=0        " start with all folds closed


" ---------- search config ----------
set ignorecase              " Now, 'foo' == 'FOO' is true!
set smartcase               " ignore case when lowercase letter only
set incsearch               " searching as you type
set nohlsearch              " nohighlight after search
