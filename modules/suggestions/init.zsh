# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/suggestions/init.zsh
# Title: Integrating zsh-autosuggestions.
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------

# Source module files.
source "${0:h}/external/zsh-autosuggestions.zsh" || return 1

# Set highlight color, default 'fg=8'.
zstyle -s ':e4czmod:module:autosuggestions:color' found \
    'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Toggle highlighting.
zstyle -t ':e4czmod:module:autosuggestions' color || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''

#  Vim key bindings.
if [[ "$key_info" ]]; then
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
