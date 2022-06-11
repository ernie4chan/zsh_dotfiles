# vim: ts=4 ft=zsh
#
# Key Bindings.
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
	return 1
fi

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

# }}}
