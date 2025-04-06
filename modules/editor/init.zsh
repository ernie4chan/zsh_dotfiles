# ---------------------------------------------------------
# vim: ft=zsh
#
# File: ./editor/init.zsh
#
# Define custom keybindings.
#
# Author: Ernie Lin
# Update: 2025/03/29
# ---------------------------------------------------------

# Check if the terminal is dumb.
# Return if requirements are not found.
[[ "$TERM" == 'dumb' ]] && return 1

# {{{ --- Overwrite default identifiers. ---

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
	'Control'		  '\C-'
	'ControlLeft'	  '\e[1;5D \e[5D \e\e[D \eOd'
	'ControlRight'	  '\e[1;5C \e[5C \e\e[C \eOc'
	'ControlPageUp'	  '\e[5;5~'
	'ControlPageDown' '\e[6;5~'
	'Escape'		  '\e'
	'Meta'			  '\M-'
	'F1'			  "$terminfo[kf1]"
	'F2'			  "$terminfo[kf2]"
	'F3'			  "$terminfo[kf3]"
	'F4'			  "$terminfo[kf4]"
	'F5'			  "$terminfo[kf5]"
	'F6'			  "$terminfo[kf6]"
	'F7'			  "$terminfo[kf7]"
	'F8'			  "$terminfo[kf8]"
	'F9'			  "$terminfo[kf9]"
	'F10'			  "$terminfo[kf10]"
	'F11'			  "$terminfo[kf11]"
	'F12'			  "$terminfo[kf12]"
	'Home'			  "$terminfo[khome]"
	'End'			  "$terminfo[kend]"
	'Insert'		  "$terminfo[kich1]"
	'Backspace'		  "$terminfo[kbs]"
	'Delete'		  "$terminfo[kdch1]"
	'Up'			  "$terminfo[kcuu1]"
	'Down'			  "$terminfo[kcud1]"
	'Left'			  "$terminfo[kcub1]"
	'Right'			  "$terminfo[kcuf1]"
	'PageUp'		  "$terminfo[kpp]"
	'PageDown'		  "$terminfo[knp]"
	'BackTab'		  "$terminfo[kcbt]"
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce
# silent bindkey failure.
for key ( ${(k)key_info} ); do
	[[ -z ${key_info[$key]} ]] && key_info[$key]='�'
done

# }}}

# {{{ --- Custom keybindings. ---

# Treat these characters as part of a word.
zstyle -s ':e4czmod:module:editor' wordchars 'WORDCHARS' \
	|| WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Runs bindkey but for all of the keymaps. Running it with no arguments will
# print out the mappings for all of the keymaps.
function bindkey-all {
	for keymap in ${(f)"$(bindkey -l)"}; do
		(( $# == 0 )) && echo "#### ${keymap}" >&2
		bindkey -M "${keymap}" "$@"
	done
}

# Reset the prompt based on the current context and
# the ps-context option.
function zle-reset-prompt {
    # If we aren't within one of the specified contexts, then we want to reset
    # the prompt with the appropriate editor_info[keymap] if there is one.
	if ! zstyle -t ':e4czmod:module:editor' ps-context || \
	  [[ $CONTEXT != (select|cont) ]]; then
 		zle reset-prompt
		zle -R
	fi
}
zle -N zle-reset-prompt

# Updates editor information when the keymap changes.
function zle-keymap-select {
	zle editor-info
}
zle -N zle-keymap-select

# Unbound keys in vicmd and viins mode will cause really odd things to happen
# such as the casing of all the characters you have typed changing or other
# undefined things. In emacs mode they just insert a tilde, but bind these keys
# in the main keymap to a noop op so if there is no keybind in the users mode
# it will fall back and do nothing.
function _prezto-zle-noop {  ; }
zle -N _prezto-zle-noop

local -a unbound_keys
unbound_keys=(
	"${key_info[F1]}"
	"${key_info[F2]}"
	"${key_info[F3]}"
	"${key_info[F4]}"
	"${key_info[F5]}"
	"${key_info[F6]}"
	"${key_info[F7]}"
	"${key_info[F8]}"
	"${key_info[F9]}"
	"${key_info[F10]}"
	"${key_info[F11]}"
	"${key_info[F12]}"
	"${key_info[PageUp]}"
	"${key_info[PageDown]}"
	"${key_info[ControlPageUp]}"
	"${key_info[ControlPageDown]}"
)

for keymap in $unbound_keys; do
	bindkey -M viins "${keymap}" _prezto-zle-noop
	bindkey -M vicmd "${keymap}" _prezto-zle-noop
done

function expand-dot-to-parent-directory-path {
	# If the buffer already ends with double dots, append a parent directory path
	# Otherwise just add a dot
	[[ $LBUFFER = *.. ]] && LBUFFER+='/..' || LBUFFER+='.'
}
zle -N expand-dot-to-parent-directory-path

# Do not expand .... to ../.. during incremental search.
zstyle -t ':e4czmod:module:editor' dot-expansion && \
	bindkey -M isearch . self-insert 2>/dev/null

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
	if [[ "$BUFFER" != su(do|)\ * ]]; then
		BUFFER="sudo $BUFFER"
		(( CURSOR += 5 ))
	fi
}
zle -N prepend-sudo

# Expand aliases
function glob-alias {
	zle _expand_alias
	zle expand-word
	zle magic-space
}
zle -N glob-alias

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Edit command in an external editor emacs style (v is used for visual mode)
bindkey -M vicmd "$key_info[Control]X$key_info[Control]E" edit-command-line

# Delete key deletes character in vimcmd mode.
#bindkey -M vicmd "$key_info[Delete]" delete-char	# Already set as default.

# Toggle comment at the start of the line.
#bindkey -M vicmd "#" vi-pound-insert			# Already set as default.

# Undo/Redo.
#bindkey -M vicmd "u" undo						# Already set as default.
#bindkey -M vicmd "$key_info[Control]R" redo	# Conflicts with fzf.
bindkey -M viins "$key_info[Control]_" undo

(( $+widgets[history-incremental-pattern-search-backward] )) && {
	bindkey -M vicmd "?" history-incremental-pattern-search-backward
	bindkey -M vicmd "/" history-incremental-pattern-search-forward
} || {
	bindkey -M vicmd "?" history-incremental-search-backward
	bindkey -M vicmd "/" history-incremental-search-forward
}

# Bind Ctrl+← and Ctrl+→ to forward/backward word.
for keymap in 'viins' 'vicmd'; do
	for key in "${(s: :)key_info[ControlLeft]}"
		bindkey -M "$keymap" "$key" vi-backward-word
	for key in "${(s: :)key_info[ControlRight]}"
		bindkey -M "$keymap" "$key" vi-forward-word
done

for keymap in 'viins'; do
	# Only bind the key if dot-expansion is enabled in zstyle.
	zstyle -t ':e4czmod:module:editor' dot-expansion && \
		bindkey -M "$keymap" "." expand-dot-to-parent-directory-path

	# Expand history on space.
	bindkey -M "$keymap" ' ' magic-space

	# Duplicate the previous word.
	bindkey -M "$keymap" "${key_info[Escape]}m" copy-prev-shell-word 

	# Expand command name to full path.
	bindkey -M "$keymap" "${key_info[Escape]}e" expand-cmd-path

	# Bind Shift + Tab to go to the previous menu item.
	bindkey -M "$keymap" "$key_info[BackTab]" reverse-menu-complete

	# Complete in the middle of word.
	bindkey -M "$keymap" "$key_info[Control]I" expand-or-complete

	# Insert 'sudo' at the beginning of the line.
	bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]S" prepend-sudo

	# Expands all aliases.
	bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]A" glob-alias
done

# }}}

# {{{ --- Layout. ---

# Set the key layout.
bindkey -v

# Unset bindkey variables.
unset key{,map}

# }}}