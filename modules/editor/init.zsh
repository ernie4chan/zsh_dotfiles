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

# {{{ --- Overwrite default identifiers. ---

# Treat these characters as part of a word. (Default in macOS)
#WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

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
	'Backspace'		  "$terminfo[kbs]"
	'Delete'		  "$terminfo[kdch1]"
	'Insert'		  "$terminfo[kich1]"
	'Home'			  "$terminfo[khome]"
	'PageUp'		  "$terminfo[kpp]"
	'End'			  "$terminfo[kend]"
	'PageDown'		  "$terminfo[knp]"
	'Up'			  "$terminfo[kcuu1]"
	'Left'			  "$terminfo[kcub1]"
	'Down'			  "$terminfo[kcud1]"
	'Right'			  "$terminfo[kcuf1]"
	'BackTab'		  "$terminfo[kcbt]"
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce
# silent bindkey failure.
for key in "${(k)key_info[@]}"; do
	if [[ -z "$key_info[$key]" ]]; then
		key_info[$key]='�'
	fi
done

# }}}

# {{{ --- Custom widgets. ---

# Runs bindkey but for all of the keymaps. Running it with no arguments
# will print out the mappings for all of the keymaps.
function bindkey-all {
	local keymap=''
	for keymap in $(bindkey -l); do
		[[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
		bindkey -M "${keymap}" "$@"
	done
}

# }}}

# {{{ --- Custom keybindings. ---

# Reset to default key bindings.
bindkey -d

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

# Expand '....' to '../..'.
zle -N expand-dot-to-parent-directory-path
if zstyle -t ':e4czmod:module:editor' dot-expansion; then
	bindkey -M viins "." expand-dot-to-parent-directory-path

	# Do not expand '....' to '../..' during incremental search.
	bindkey -M isearch "." self-insert 2> /dev/null
fi

# Undo/Redo.
bindkey -M viins "$key_info[Control]_" undo
#bindkey -M vicmd "u" undo					  # Default bindkey.
#bindkey -M vicmd "$key_info[Control]R" redo  # Conflicts with fzf.

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Keymaps for viins & vicmd.
for keymap in 'viins' 'vicmd'; do
	# Jumping through lines.
	bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
	bindkey -M "$keymap" "$key_info[End]" end-of-line
done

# Keymaps for vicmd.
for keymap in 'vicmd'; do
	# Edit command in an external editor.
	bindkey -M  "$keymap" "$key_info[Control]E" edit-command-line

	# Incremental search.
	if (( $+widgets[history-incremental-pattern-search-backward] )); then
		bindkey -M "$keymap" "?" history-incremental-pattern-search-backward
		bindkey -M "$keymap" "/" history-incremental-pattern-search-forward
	else
		bindkey -M "$keymap" "?" history-incremental-search-backward
		bindkey -M "$keymap" "/" history-incremental-search-forward
	fi
done

# Keymaps for viins.
for keymap in 'viins'; do
	# Defaults.
	bindkey -M "$keymap" "$key_info[Insert]" overwrite-mode
	bindkey -M "$keymap" "$key_info[Delete]" delete-char
	bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char

	bindkey -M "$keymap" "$key_info[Left]" backward-char
	bindkey -M "$keymap" "$key_info[Right]" forward-char

	# Bind Shift+Tab to go to the previous menu item.
	bindkey -M "$keymap" "$key_info[BackTab]" reverse-menu-complete

	# Expand command name to full path.
	for key in "$key_info[Control]Xp"
		bindkey -M "$keymap" "$key" expand-cmd-path

	# Useful in 'autosuggestions'.
    bindkey -M "$keymap" "$key_info[Control]B" vi-backward-word
	bindkey -M "$keymap" "$key_info[Control]F" vi-forward-word
	bindkey -M "$keymap" "$key_info[Control]E" vi-add-eol

	# Expand history on space.
	bindkey -M "$keymap" ' ' magic-space


done

# }}}

# {{{ --- Layout. ---

# Set the key layout.
bindkey -v
export KEYTIMEOUT=1

# Unset bindkey variables.
unset key{,map}

# }}}
