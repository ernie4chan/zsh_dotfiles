# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Set base directory.
ZDOTDIR="$HOME/.zsh"

# Failsafe test purposes and debugging.
#zsh -x 2> "$ZDOTDIR"/zsh-error.log

# Load 'zstyle' sheet.
[[ ! -f "$ZDOTDIR"/zstyle ]] || source "$ZDOTDIR"/zstyle

# Load all the modules you want!
zstyle ':zmodule:load' pmodule \
	'environment' \
	'gnu_utility' \
	'aliases' \
	'editor' \
	'fzf' \
	'gpg' \
	'tmux' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions' \
	'prompt' 

# Load 'pmodload'.
[[ ! -f "$ZDOTDIR"/pmodload.zsh ]] || source "$ZDOTDIR"/pmodload.zsh

# Unset base directory.
unset ZDOTDIR

[[ ! -s $(which thefuck) ]] || eval $(thefuck --alias)
