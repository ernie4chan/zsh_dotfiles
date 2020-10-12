# vim: ft=zsh

# Failsafe test purposes and debugging.
#zsh -x 2> ${HOME}/zsh-error.log

# Se base directory.
ZDOTDIR="$HOME/.zsh"

# Load 'zstyle'.
[[ ! -f "$ZDOTDIR"/zstyle ]] || source "$ZDOTDIR"/zstyle

# Load all the modules you want!
zstyle ':zmodule:load' pmodule \
	'environment' \
	'prompt' \
	'editor' \
	'gnu_utility' \
	'aliases' \
	'fzf' \
	'gpg' \
	'tmux' \
	'autosuggestions' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search'

# Load 'pmodload'.
[[ ! -f "$ZDOTDIR"/pmodload.zsh ]] || source "$ZDOTDIR"/pmodload.zsh

# Unset base directory.
unset ZDOTDIR

[[ ! -s $(which thefuck) ]] || eval $(thefuck --alias)
