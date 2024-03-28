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
	'prompt' \
	'editor' \
	'utility' \
	'gpg' \
	'fzf' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'autosuggestions'
# Unloaded Modules!
#	'tmux'
#	'macos'

# Load Modules.
zshinit="${ZDOTDIR:-$HOME/.zsh}/zshinit"
[[ ! -f "$zshinit" ]] || source "$zshinit"

unset {zshstyle,zshinit}

# Execute code that does not affect the current session in the background.
{
# Compile the completion dump to increase startup speed.
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
if [[ -s "$_comp_path" && (! -s "${_comp_path}.zwc" || "$_comp_path" -nt "${_comp_path}.zwc") ]]; then
		zcompile "$_comp_path"
fi
unset _comp_path
} &!

# Remove unwated init files.
_unwanted_file="${HOME}/.zcompdump"
if [[ -f "$_unwanted_file" ]]; then
		rm "$_unwanted_file"
fi
unset _unwanted_file

# For WSL2.
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1
