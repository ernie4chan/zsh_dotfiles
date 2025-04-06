# ---------------------------------------------------------
# vim: ft=zsh
#
# File: ./autosuggestions/init.zsh
#
# Integrates zsh-autosuggestions.
#
# Author: Ernie Lin
# Update: 2022/06/10
# ---------------------------------------------------------

# Source module files.
source ${0:h}/external/zsh-autosuggestions.zsh || return 1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Set highlight color, default 'fg=8'.
zstyle -s ':e4czmod:module:autosuggestions:color' found \
	'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Disable highlighting.
if ! zstyle -t ':e4czmod:module:autosuggestions' color; then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''
fi

# {{{ --- Smart URLs. ---

# This logic comes from an old version of zim. Essentially, bracketed-paste was
# added as a requirement of url-quote-magic in 5.1, but in 5.1.1 bracketed
# paste had a regression. Additionally, 5.2 added bracketed-paste-url-magic
# which is generally better than url-quote-magic so we load that when possible.
autoload -Uz is-at-least
if [[ ${ZSH_VERSION} != 5.1.1 && ${TERM} != "dumb" ]]; then
	if is-at-least 5.2; then
		autoload -Uz bracketed-paste-url-magic
		zle -N bracketed-paste bracketed-paste-url-magic
	else
		if is-at-least 5.1; then
			autoload -Uz bracketed-paste-magic
			zle -N bracketed-paste bracketed-paste-magic
		fi
	fi
	autoload -Uz url-quote-magic
	zle -N self-insert url-quote-magic
fi

# Reference: "https://forum.endeavouros.com/t/tip-better-url-pasting-in-zsh/6962"
# Now the fix, setup these two hooks:
pasteinit() {
	OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
	zle -N self-insert url-quote-magic
}

pastefinish() {
	zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# And finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# }}}
