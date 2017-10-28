" use vim settings"
set nocompatible

" security
set modelines=0

" hide buffers
set hidden

" caching
set undofile
set undodir=~/.vim/undo

set backup
set backupdir=~/.vim/tmp
set writebackup

set directory=~/.vim/tmp

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/tmp/.viminfo

" fuzzy find
set path+=**

" lazy file name tab completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" ignore files that vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

" case insensitive search
set ignorecase
set smartcase
set infercase

" searching
set hlsearch
set incsearch

" /g flag on substitutions by default
set gdefault

" make backspace great again
set backspace=indent,eol,start

" indents of four spaces
set shiftwidth=4

" dont expand tabs
set noexpandtab

" indentation every four columns
set tabstop=4

" let backspace delete indent
set softtabstop=4

" auto indenting
set smartindent
set autoindent

" set leader key to comma
let mapleader=","

" get rid of weird esc delay
set ttimeoutlen=0
set timeoutlen=1000
