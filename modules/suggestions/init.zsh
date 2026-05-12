# ---------------------------------------------------------
# vim: ft=zsh
# File: ./autosuggestions/init.zsh
# Title: Integrating zsh-autosuggestions.
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------

# Source module files.
source "${0:h}/external/zsh-autosuggestions.zsh" || return 1

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Set highlight color, default 'fg=8'.
zstyle -s ':e4czmod:module:autosuggestions:color' found \
    'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Toggle highlighting.
zstyle -t ':e4czmod:module:autosuggestions' color || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''

# bracketed-paste-url-magic (5.2+) is better than url-quote-magic.
# Reference: https://forum.endeavouros.com/t/tip-better-url-pasting-in-zsh/6962
if [[ $TERM != 'dumb' ]]; then
    autoload -Uz bracketed-paste-url-magic url-quote-magic
    zle -N bracketed-paste bracketed-paste-url-magic
    zle -N self-insert url-quote-magic
fi

# Fix autosuggestions interference with bracketed-paste.
pasteinit()   {
	OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
	zle -N self-insert url-quote-magic
}

pastefinish() {
	zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init   pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# And finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
