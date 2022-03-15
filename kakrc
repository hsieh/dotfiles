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
}

plug "andreyorst/fzf.kak" config %{
    map -docstring 'fzf mode' global normal ',' ': fzf-mode<ret>'
} demand fzf %{
    set-option global fzf_file_command 'rg'
    set-option global fzf_project_use_tilda true
} config %{
}

plug "andreyorst/kaktree"  defer kaktree %{
    set-option global kaktree_double_click_duration '0.5'
    set-option global kaktree_indentation 1
    set-option global kaktree_dir_icon_open '- '
    set-option global kaktree_dir_icon_close '+ '
    set-option global kaktree_file_icon ' #'
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

# plug "dracula/kakoune" theme config %{
#        colorscheme dracula
# }

plug "chriswalker/golang.kak" config %{
    set-option buffer formatcmd 'gofmt'
}


hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
    lsp-enable-window
    add-highlighter buffer/ number-lines
}

colorscheme gruvbox
