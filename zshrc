# ---------------------------------------------------------
# vim: ts=4 ft=zsh
#
# File: .zshrc
#
# The Master Mind of ZSH!
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"

# Load modules! Remember that the order matters.
zstyle ':e4czmod:load' pmodule \
	'helper' \
	'environment' \
	'tmux' \
	'prompt' \
	'utility' \
	'editor' \
	'fzf' \
	'gpg' \
	'macos' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'

#'gnu_utility' goes before 'utility'.

# Load Init File.
zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"
if [[ -f "$zshinit" ]]; then
	source "$zshinit"
fi
unset zshinit
