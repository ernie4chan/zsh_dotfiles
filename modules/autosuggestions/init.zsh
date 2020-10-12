# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Load dependencies.
pmodload 'editor'

# Add zsh-autosuggestions.
source ${0:h}/external/zsh-autosuggestions.zsh || return 1

# Set highlight color, default 'fg=8'.
zstyle -s ':zmodule:autosuggestions:color' found \
	'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Disable highlighting.
if ! zstyle -t ':zmodule:autosuggestions' color; then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''
fi

# Key Bindings
if [[ -n "$key_info" ]]; then
	# vi
	bindkey -M viins "$key_info[Control]F" vi-forward-word
	bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
