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
bindkey -M vicmd "^X" edit-command-line

# }}}

# {{{ --- Expand dots. ---

# Load function to expand '....' to '../..'.
zle -N expand-dot-to-parent-directory-path

# Expand '....' to '../..'.
if zstyle -t ':e4czmod:module:editor' dot-expansion; then
	bindkey -M viins "." expand-dot-to-parent-directory-path

	# Do not expand '....' to '../..' during incremental search.
	bindkey -M isearch "." self-insert 2> /dev/null
fi
# }}}

# {{{ --- Layout. ---

# Set the key layout.
bindkey -v
export KEYTIMEOUT=1

# }}}
