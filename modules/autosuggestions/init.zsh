# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Add zsh-autosuggestions.
source ${0:h}/external/zsh-autosuggestions.zsh || return 1

# Set highlight color, default 'fg=8'.
zstyle -s ':zmodule:autosuggestions:color' found \
  'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
