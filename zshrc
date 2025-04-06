# ---------------------------------------------------------
# vim: ft=zsh
#
# File: ./zshrc
#
# The Master Mind of Zsh!
#
# Author: Ernie Lin
# Update: 2025/03/30
# ---------------------------------------------------------

# Load Modules. The order matters!
zstyle ':e4czmod:load' pmodule \
	'zstyle' \
	'environment' \
	'prompt' \
	'editor' \
	'utility' \
	'fzf' \
	'gpg' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'
	# Modules not loaded:
	#'tmux'

zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"

[[ -r "$zshinit" ]] && source "$zshinit"

unset zsh{style,init}

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"
