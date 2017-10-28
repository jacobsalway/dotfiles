" true colour terminal
"set termguicolors
"set t_Co=256

" show matching brackets
set showmatch

" disable startup message
set shortmess+=I

" syntax highlighting
syntax on
set synmaxcol=512
filetype indent plugin on

" only render when necessary
set lazyredraw

" scroll offset
set so=15

" line numbers
set number
set relativenumber

" no line wrapping
set nowrap

" highlight cursor
set cursorline

" netrw file explorer
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=10
let g:netrw_banner=0
