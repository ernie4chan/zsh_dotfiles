# vim: ts=4 ft=zsh
#
# Integrates zsh-autosuggestions.
#

# Source module files.
source ${0:h}/external/zsh-autosuggestions.zsh || return 1

# Set highlight color, default 'fg=8'.
zstyle -s ':e4czmod:module:autosuggestions:color' found \
	'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Disable highlighting.
if ! zstyle -t ':e4czmod:module:autosuggestions' color; then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''
fi

# Vim Key Bindings
if [[ -n "$key_info" ]]; then
	bindkey -M viins "$key_info[Control]F" vi-forward-word
	bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
