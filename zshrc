# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/zshrc
# Title: The Master Mind of Zsh!
# Maintainer: Ernie Lin
# Update:
#	20250330
#	20260509
# ---------------------------------------------------------

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"

# Load Modules. The order matters!
zstyle ':e4czmod:load' pmodule \
	'zstyle' \
	'environment' \
	'prompt' \
	'editor' \
	'utilities' \
	'fzf' \
	'gpg' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'
	# Modules not loaded:
	#'tmux'
	#'spectrum' p10k handles all the colors.

zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"
[[ -r "$zshinit" ]] && source "$zshinit"

unset zshinit zshstyle
