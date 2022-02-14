-- load standard vis module, providing parts of the Lua API
require('vis')

local plug = require('plugins/vis-plug')

-- configure plugins in an array of tables with git urls and options
local plugins = {
	{ url = 'https://repo.or.cz/vis-goto-file.git' },
	{ url = 'https://gitlab.com/kdsch/vis-go.git' },
	-- { url = 'https://repo.or.cz/vis-surround.git' },
	-- { url = 'https://repo.or.cz/vis-toggler.git' },
	{ url = 'kupospelov/vis-ctags' },
	{ url = 'erf/vis-highlight', alias = 'hi' },
	{ url = 'https://git.sr.ht/~mcepl/vis-fzf-open', alias = 'fzf' },
	{ url = 'peaceant/vis-fzf-mru', alias = 'mru', file = 'fzf-mru' },
	{ url = 'samlwood/vis-gruvbox', theme = true, file = 'gruvbox' },
}

-- require and optionally install plugins on init
plug.init(plugins, true)

-- Path to the fzf executable (default: "fzf")
plug.plugins.fzf.fzf_path = (
    "FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g \"\"' fzf"
)
-- Arguments passed to fzf (default: "")
plug.plugins.fzf.fzf_args = "-q '!.class ' --height=40%"

my_fzf_args = string.gsub([[
    --bind=$my_fzf_key_bindings \
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108 \
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168 \
    --delimiter / --nth -1 \
    --height=70% \
    --inline-info \
    --no-mouse \
    --preview-window=up:70% \
    --preview="(
        bat --style=changes,grid,numbers --color=always {} ||
        highlight -O ansi -l {} ||
        coderay {} ||
        rougify {} ||
        cat {}
    ) 2> /dev/null | head -1000"
]], '%$([%w_]+)', {
    my_fzf_key_bindings=table.concat({
        "alt-j:preview-down",
        "alt-k:preview-up",
        "ctrl-f:preview-page-down",
        "ctrl-b:preview-page-up",
        "?:toggle-preview",
        "alt-w:toggle-preview-wrap",
        "ctrl-z:clear-screen"
    }, ",")
})

-- Arguments passed to fzf (default: "")
plug.plugins.fzf.fzf_args = my_fzf_args

plug.plugins.mru.fzfmru_args = "--delimiter / --nth -1"

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	-- vis:command('set theme default-16')
	-- mru
	vis:map(vis.modes.NORMAL, ",z", ":fzfmru<Enter>")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number')
	vis:command('set rnu')
	vis:command('map! normal ,f :fzf<Enter>')
	-- access plugins via alias
	plug.plugins.hi.patterns[' +\n'] = { style = 'back:#444444' }
end)
