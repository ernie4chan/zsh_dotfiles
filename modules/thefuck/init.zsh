# vim: ts=4 ft=zsh
#
# The Fuck.
#

(( ! $+commands[thefuck] )) && { \
	echo 'thefuck is not installed'; \
	echo 'See https://github.com/nvbn/thefuck#installation'; \
	return 1; \
}

# Register alias.
eval "$(thefuck --alias)"

fuck-command-line() {
	local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
	[[ -z $FUCK ]] && echo -n -e "\a" && return
	BUFFER=$FUCK
	zle end-of-line
}

zle -N fuck-command-line

# Defined shortcut keys: [Esc] [Esc].
for keymap in 'emacs' 'viins' 'vicmd'; do
	bindkey -M "$keymap" '\e\e' fuck-command-line
done
unset keymap
