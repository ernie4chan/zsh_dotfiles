# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./fzf/init.zsh
#
# Make fuzzy file finder fun!
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Return if requirements are not found.
(( ! $+commands[fzf] )) && return 1

# Add fzf to path.
if is-darwin; then
	[[ ! "$PATH" == */usr/local/opt/fzf/bin* ]] && \
		export PATH="$PATH:/usr/local/opt/fzf/bin"
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null; \
		source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2> /dev/null
elif is-linux; then
	[[ ! "$PATH" == */usr/share/fzf* ]] && \
		export PATH="$PATH:/usr/share/fzf"
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/share/fzf/completion.zsh" 2>/dev/null; \
		source "/usr/share/fzf/key-bindings.zsh" 2>/dev/null
fi


# Modify default Alt+C.
#for keymap in 'viins' 'vicmd'; do
#	# Jumping through lines.
#	bindkey -M "$keymap" "$key_info[Control]Z" fzf-cd-widget
#done
#unset keymap
