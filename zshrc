# vim: ts=4 ft=zsh
#
# The Master Mind of ZSH!
#

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"

# Load modules! Remember that the order matters.
zstyle ':e4czmod:load' pmodule \
	'environment' \
	'helper' \
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
#'thefuck' goes before 'completions'.

# Load Init File.
[[ ! -f "${ZDOTDIR:-$HOME/.zsh}/zshinit.zsh" ]] || source "${ZDOTDIR:-$HOME/.zsh}/zshinit.zsh"
