function! AdaptScheme()
	highlight clear CursorLine
	highlight Normal ctermbg=none
	highlight LineNr ctermbg=none
	highlight Folded ctermbg=none
	highlight NonText ctermbg=none
	highlight SpecialKey ctermbg=none
	highlight VertSplit ctermbg=none
	highlight Signcolumn ctermbg=none
endfunction

autocmd ColorScheme * call AdaptScheme()

" lightline
set laststatus=2
set noshowmode

let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ }

" make the lightline background transparent
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

" colour scheme
colorscheme molokai 
