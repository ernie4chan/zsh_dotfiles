# vim: ts=2 sw=2 sts=2 noet ft=zsh

# Failsafe test purposes and debugging.
#zsh -x 2> "$ZDOTDIR"/zsh-error.log

# Set base directory.
ZDOTDIR="$HOME/.zsh"

# Load 'zstyle' sheet.
[[ ! -f "$ZDOTDIR/zshstyle" ]] || source "$ZDOTDIR/zshstyle"

# Load all the modules you want! Remember that order matters.
zstyle ':zmodule:load' pmodule \
	'environment' \
	'gnu_utility' \
	'aliases' \
	'editor' \
	'fzf' \
	'gpg' \
	'tmux' \
	'thefuck' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions' \
	'prompt' 

# Load 'pmodload'.
[[ ! -f "$ZDOTDIR/pmodload.zsh" ]] || source "$ZDOTDIR/pmodload.zsh"
