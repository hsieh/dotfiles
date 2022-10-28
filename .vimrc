set nocp
source $VIMRUNTIME/vimrc_example.vim

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

set signcolumn=auto
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set colorcolumn=121

nnoremap * :keepjumps normal! mi*`i<CR>

" after you paste something, press gb to select it in visual mode
" so that you could format it or do something else
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

function s:customHi()
  highlight ColorColumn0 ctermbg=magenta
  highlight Trailing0 ctermbg=darkgreen guibg=lightgreen
  call matchadd('ColorColumn0', '\%81v', 100)
  call matchadd('Trailing0', '\s\+$', 100)
endfunction

call s:customHi()

augroup customHi_
  au!
  "autocmd BufEnter * call s:customHi()
  autocmd WinEnter * call s:customHi()
augroup END

syntax enable
filetype plugin on

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

function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf
    try
      normal mx
    catch
      echo "Canceled"
    endtry

    cunmap <buffer> <CR>
  endif
endfunction

function! NetrwMapping()
    nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

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

let &shell='bash --login'

" disable the screen switching
set t_ti= t_te=

setl virtualedit=all
augroup ved
  au!
  autocmd InsertEnter * set virtualedit=""
  autocmd InsertLeave * set virtualedit=all
augroup END

" vim: set ft=vim :
