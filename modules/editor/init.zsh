# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./editor/init.zsh
#
# Define custom keybindings.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Return if requirements are not found.
[[ "$TERM" == 'dumb' ]] && return 1

# {{{ --- External editor. ---
#
# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Edit command in an external editor emacs style (v is used for visual mode).
for keymap in 'emacs' 'vicmd'; do
	bindkey -M "$keymap" "^X^E" edit-command-line
done

# }}}

# {{{ --- Expand dots. ---

# Load function to expand '....' to '../..' .
zle -N expand-dot-to-parent-directory-path

if zstyle -t ':e4czmod:module:editor' dot-expansion; then
	for keymap in 'emacs' 'viins'; do
		# Expand '....' to '../..' .
		bindkey -M "$keymap" "." expand-dot-to-parent-directory-path
	done
	# Do not expand .... to ../.. during incremental search.
	bindkey -M isearch . self-insert 2> /dev/null
fi

# }}}

# {{{ --- Layout. ---

# Set the key layout.
zstyle -s ':e4czmod:module:editor' key-bindings 'key_bindings'
if [[ "$key_bindings" == vi ]]; then
	bindkey -v
elif [[ "$key_bindings" == (emacs|) ]]; then
	bindkey -e
else
	print "e4czmod: editor: invalid key bindings: $key_bindings" >&2
fi

export KEYTIMEOUT=1

# }}}
