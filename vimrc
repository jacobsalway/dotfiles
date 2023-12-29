set nocompatible

" indentation
set expandtab
set shiftwidth=2
set smartindent
set tabstop=2
set softtabstop=2

" statusline
set laststatus=3
set noshowmode

" line numbers
set number
set relativenumber

" colorscheme
syntax on

" make background transparent
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE

" disable splash screen
set shortmess=I
