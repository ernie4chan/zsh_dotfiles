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

# Read Modules! Remember that order matters.
zstyle ':e4czmod:load' pmodule \
	'helper' \
	'environment' \
	'tmux' \
	'prompt' \
	'editor' \
	'utility' \
	'gpg' \
	'fzf' \
	'macos' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'

# Load Modules.
zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"
[[ ! -f "$zshinit" ]] || source "$zshinit"

unset {zshstyle,zshinit}
