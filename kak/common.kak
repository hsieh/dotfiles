set-option global ui_options ncurses_set_title=false
set-option global ui_options ncurses_assistant=none

set-option global jumpclient client0

map -docstring "next buffer" global goto 'n' '<esc>: buffer-next<ret>'
map -docstring "previous buffer" global goto 'p' '<esc>: buffer-previous<ret>'

set-option global grepcmd 'rg --hidden --follow --smart-case --with-filename --column'

hook global WinSetOption filetype=(go|rust) %{
    add-highlighter buffer/numbers number-lines -relative -hlcursor
    add-highlighter buffer/matching show-matching
    set-option buffer formatcmd 'goimports'
}

# easy surround, like helix
declare-user-mode match
map global match m 'm' -docstring 'Goto matching bracket'
map global match s ':surround<ret>' -docstring 'Surround add'
map global match r ':change-surround<ret>' -docstring 'Surround replace'
map global match d ':delete-surround<ret>' -docstring 'Surround delete'
map global match a '<a-a>' -docstring 'Select around object'
map global match i '<a-i>' -docstring 'Select inside object'
map global normal 'm' ': enter-user-mode match<ret>'

colorscheme gruvbox
