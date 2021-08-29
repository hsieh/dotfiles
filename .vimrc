set nocp
set backspace=indent,eol,start
set display=truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=8192
set incsearch
set langnoremap
set nolangremap
set mouse-=a
set nrformats=bin,hex
set ruler
set scrolloff=3
set showcmd
set ttimeout
set ttimeoutlen=100
set nowrap
"
set hidden

set splitright splitbelow

set colorcolumn=121
highlight ColorColumn0 ctermbg=magenta
call matchadd('ColorColumn0', '\%81v', 100)

highlight Trailing0 gui=underline guifg=red ctermbg=red
match Trailing0 /\(\t\|\ \)\+$/

syntax enable
filetype plugin on

set signcolumn=auto
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" indent settings
"filetype indent on
"autocmd Filetype c setl noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
"autocmd Filetype cpp setl noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
"autocmd Filetype java setl expandtab tabstop=4 shiftwidth=4 softtabstop=4

set path+=**
set wildmenu

let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" let g:netrw_alto=0
let g:netrw_winsize=0
let g:netrw_preview=1

autocmd FileType netrw setl bufhidden=delete " or use :qa!

set laststatus=1 showtabline=1

" → u2192; ↲ u21b2
set listchars=tab:→\ ,eol:↲

command! MakeTags !ctags -R .

" auto save & load view
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

nnoremap <silent> <Leader>q  :copen <CR>
nnoremap <silent> [q  :cnext <CR>
nnoremap <silent> ]q  :cprev <CR>
nnoremap <silent> [Q  :cfirst <CR>
nnoremap <silent> ]Q  :clast <CR>

" vim: set ft=vim :
