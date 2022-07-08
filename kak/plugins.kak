evaluate-commands %sh{
    plugins="$kak_config/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && \
        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}

set-option global plug_always_ensure true
set-option global plug_profile true

plug "andreyorst/plug.kak" noload

plug "delapouite/kakoune-text-objects"

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
} config %{
    hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
        lsp-enable-window
    }
    map -docstring 'lsp' global normal '<c-p>' ': enter-user-mode lsp<ret>'
}

plug "ul/kak-tree" do %{
    cargo install --locked --force --path . --features "all"
}

plug "occivink/kakoune-find" config %{
    define-command -docstring "grep-apply-changes: apply changes specified in current *grep* buffer to their respective files" \
    grep-apply-changes %{ find-apply-changes -force }
}

#plug "andreyorst/base16-gruvbox.kak" theme %{
#    if %sh{ [ -n "${PATH##*termux*}" ] && echo true || echo false } %{
#        colorscheme base16-gruvbox-dark-soft
#    } %{
#        colorscheme base16-gruvbox-dark-hard
#    }
#}

plug "andreyorst/fzf.kak" defer fzf-project %{
    set-option global fzf_project_use_tilda true
} defer fzf-file %{
    set-option global fzf_highlight_command 'bat'

    # set-option global fzf_file_command 'rg'
    declare-option str-list fzf_exclude_files "*.o" "*.bin" "*.obj" ".*cleanfiles"
    declare-option str-list fzf_exclude_dirs ".git" ".svn"
    set-option global fzf_file_command %sh{
        if [ -n "$(command -v fd)" ]; then
            eval "set -- ${kak_quoted_opt_fzf_exclude_files:-} ${kak_quoted_opt_fzf_exclude_dirs:-}"
            while [ $# -gt 0 ]; do
                exclude="$exclude --exclude '$1'"
                shift
            done
            cmd="fd . --no-ignore --type f --follow --hidden $exclude"
        else
            eval "set -- $kak_quoted_opt_fzf_exclude_files"
            while [ $# -gt 0 ]; do
                exclude="$exclude -name '$1' -o"
                shift
            done
            eval "set -- $kak_quoted_opt_fzf_exclude_dirs"
            while [ $# -gt 0 ]; do
                exclude="$exclude -path '*/$1' -o"
                shift
            done
            cmd="find . \( ${exclude% -o} \) -prune -o -type f -follow -print"
        fi
        echo "$cmd"
    }
} config %{
    map -docstring 'fzf mode' global normal ',' ': fzf-mode<ret>'
}

plug "andreyorst/kaktree" defer kaktree %{
    set-option global kaktree_show_help false
    set-option global kaktree_double_click_duration '0.5'
    set-option global kaktree_indentation 1
    set-option global kaktree_dir_icon_open '-'
    set-option global kaktree_dir_icon_close '+'
    set-option global kaktree_file_icon '#'
    set-option global kaktree_show_hidden false
} config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/show-whitespaces
    }
    kaktree-enable
    ## fixed kaktree bug
    hook global -always KakEnd .* %{ nop %sh{ killtree }}
    map -docstring 'kaktree' global normal '<F7>' ': kaktree-toggle<ret>'
}

plug "andreyorst/smarttab.kak" defer smarttab %{
   set-option global softtabstop 4 
} config %{
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl) expandtab
    hook global WinSetOption filetype=(makefile|gas|go) noexpandtab
    hook global WinSetOption filetype=(c|cpp|go) smarttab
    hook global WinSetOption filetype=(go) %{
        set-option buffer tabstop 4
    }
}

plug "andreyorst/powerline.kak" defer powerline %{
    set-option global powerline_ignore_warnings true
    set-option global powerline_format 'git bufname line_column mode_info filetype client lsp session position'
    set-option global powerline_separator ''
    set-option global powerline_separator_thin ''
} defer powerline_bufname %{
    set-option global powerline_shorten_bufname 'short'
} defer powerline_gruvbox %{
    powerline-theme gruvbox
} config %{
    powerline-start
}

plug "https://gitlab.com/Screwtapello/kakoune-inc-dec" config %{
    map global normal <c-a> ': inc-dec-modify-numbers + %val{count}<ret>'
    map global normal <c-x> ': inc-dec-modify-numbers - %val{count}<ret>'
}

plug "chriswalker/golang.kak"
plug "occivink/kakoune-vertical-selection"
plug "h-youhei/kakoune-surround"
#plug "alexherbo2/surround.kak"
