# vim: ts=4 ft=zsh
#
# The Master Mind of ZSH!
#

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"

# Load modules! Remember that the order matters.
zstyle ':e4czmod:load' pmodule \
	'helper' \
	'environment' \
	'tmux' \
	'prompt' \
	'utility' \
	'fzf' \
	'gpg' \
	'macos' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'

#'editor' goes before 'fzf'.
#'gnu_utility' goes before 'utility'.
#'thefuck' goes before 'completions'.

# Load Init File.
[[ ! -f "${ZDOTDIR:-$HOME/.zsh}/zshinit.zsh" ]] || source "${ZDOTDIR:-$HOME/.zsh}/zshinit.zsh"
