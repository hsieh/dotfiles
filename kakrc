evaluate-commands %sh{
    plugins="$kak_config/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && \
        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}

plug "andreyorst/plug.kak" noload

plug "delapouite/kakoune-text-objects"

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
} config %{
    hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
        lsp-enable-window
        add-highlighter buffer/ number-lines
    }
    hook global WinSetOption filetype=(go) %{
        set-option buffer formatcmd 'gofmt'
    }
}

plug "andreyorst/fzf.kak" defer fzf-project %{
    set-option global fzf_project_use_tilda true
} defer fzf-file %{
    set-option global fzf_file_command 'rg'
    set-option global fzf_highlight_command 'bat'
} config %{
    map -docstring 'fzf mode' global normal ',' ': fzf-mode<ret>'
}

plug "andreyorst/kaktree" defer kaktree %{
    set-option global kaktree_double_click_duration '0.5'
    set-option global kaktree_indentation 1
    set-option global kaktree_dir_icon_open '-'
    set-option global kaktree_dir_icon_close '+'
    set-option global kaktree_file_icon '#'
} config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
            remove-highlighter buffer/matching
            remove-highlighter buffer/wrap
            remove-highlighter buffer/show-whitespaces
    }
    kaktree-enable
    map -docstring 'kaktree' global normal '<F7>' ': kaktree-toggle<ret>'
}

plug "chriswalker/golang.kak"
plug "occivink/kakoune-vertical-selection"
plug "h-youhei/kakoune-surround"

set-option global grepcmd 'rg --hidden --follow --smart-case --with-filename --column'

colorscheme gruvbox

# easy surround, like helix
declare-user-mode match
map global match m 'm' -docstring 'Goto matching bracket'
map global match s ':surround<ret>' -docstring 'Surround add'
map global match r ':change-surround<ret>' -docstring 'Surround replace'
map global match d ':delete-surround<ret>' -docstring 'Surround delete'
map global match a '<a-a>' -docstring 'Select around object'
map global match i '<a-i>' -docstring 'Select inside object'
map global normal 'm' ': enter-user-mode match<ret>'
