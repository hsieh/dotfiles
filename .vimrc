version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-U> u
map! <D-v> *
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
vmap <BS> "-d
vmap <D-x> "*d
vmap <D-c> "*y
vmap <D-v> "-d"*P
nmap <D-v> "*P
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set display=truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=2048
set incsearch
set langnoremap
set nolangremap
set mouse-=a
set nrformats=bin,hex
set ruler
set scrolloff=0
set showcmd
set ttimeout
set ttimeoutlen=100
set wildmenu
"
set hidden

set colorcolumn=121
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" set signcolumn=yes
set tabstop=4 softtabstop=4
set nowrap
set path+=**
command! MakeTags !ctags -R .
let g:netrw_banner=0       " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" vim: set ft=vim :
