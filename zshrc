# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: .zshrc
#
# The Master Mind of Zsh!
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Failsafe test purposes and debugging.
#zsh -x 2> "$HOME/zsh_error.log"

# Load Styles.
zshstyle="${ZDOTDIR:-$HOME/.zsh}/zshstyle"
[[ ! -f "$zshstyle" ]] || source "$zshstyle"

# Load Modules. The order matters.
zstyle ':e4czmod:load' pmodule \
	'helper' \
	'environment' \
	'prompt' \
	'editor' \
	'gpg' \
	'utility' \
	'fzf' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'
# Modules not loaded:
#	'wsl2'
#	'tmux'
#	'macos'

zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"
[[ ! -f "$zshinit" ]] || source "$zshinit"

unset {zshstyle,zshinit}
