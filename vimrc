set nocompatible

call plug#begin()

Plug 'Mofiqul/vscode.nvim'

if has('nvim')
  Plug 'tomasiser/vim-code-dark'
  Plug 'nvim-tree/nvim-tree.lua'
endif

call plug#end()

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

" make background transparent
function! BackgroundTransparent() abort
  hi Normal guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  "vim needs this one specifically
  hi EndOfBuffer guibg=NONE ctermbg=NONE
endfunction
autocmd ColorScheme * call BackgroundTransparent()

" colorscheme
syntax on
if has('nvim')
  colorscheme vscode
else
  colorscheme codedark
endif

" highlight trailing whitespace with a red background
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" disable splash screen
set shortmess=I

let mapleader = ','

" configure nvim-tree
if has('nvim')
  nnoremap <Leader>f :NvimTreeToggle<CR>
  " need an absolute path
  source ~/.config/nvim/nvim-tree-config.lua

  " make background transparent
  hi NvimTreeNormal guibg=NONE
endif
