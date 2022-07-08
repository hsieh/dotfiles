require-module kak
add-highlighter shared/kakrc/code/if_else regex \b(if|when|unless)\b 0:keyword

define-command true -params 2 %{ eval %arg{1} }
define-command false -params 2 %{ eval %arg{2} }
define-command if -params 3 %{ eval -verbatim %arg{1} %arg{2} %arg{3} }
define-command when -params 2 %{ eval -verbatim %arg{1} %arg{2} nop }
define-command unless -params 2 %{ eval -verbatim %arg{1} nop %arg{2} }

define-command dvp2qwerty %{source ~/.config/kak/layout/dvp2qwerty.kak}
define-command nodvp2qwerty %{source ~/.config/kak/layout/nodvp2qwerty.kak}

define-command finder -params 1 -shell-script-candidates %{ find -L . -type f } %{ edit %arg{1} }

