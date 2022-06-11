# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: ./autosuggestions/init.zsh
#
# Integrates zsh-autosuggestions.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Source module files.
source ${0:h}/external/zsh-autosuggestions.zsh || return 1

# Set highlight color, default 'fg=8'.
zstyle -s ':e4czmod:module:autosuggestions:color' found \
	'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Disable highlighting.
if ! zstyle -t ':e4czmod:module:autosuggestions' color; then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''
fi

# Vim Keybindings
bindkey -M viins "^F" vi-forward-word
bindkey -M viins "^E" vi-add-eol
