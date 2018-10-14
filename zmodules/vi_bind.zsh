#!/usr/bin/env zsh

# Beep on error in line editor.
setopt BEEP

# Enable Vi-mode.
bindkey -v

# Kill the lag, otherwise there will be a 0.4s lag when changing modes.
export KEYTIMEOUT=1

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
	'Control'      '\C-'
	'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd'
	'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc'
	'Escape'       '\e'
	'Meta'         '\M-'
	'Backspace'    "^?"
	'Delete'       "^[[3~"
	'F1'           "$terminfo[kf1]"
	'F2'           "$terminfo[kf2]"
	'F3'           "$terminfo[kf3]"
	'F4'           "$terminfo[kf4]"
	'F5'           "$terminfo[kf5]"
	'F6'           "$terminfo[kf6]"
	'F7'           "$terminfo[kf7]"
	'F8'           "$terminfo[kf8]"
	'F9'           "$terminfo[kf9]"
	'F10'          "$terminfo[kf10]"
	'F11'          "$terminfo[kf11]"
	'F12'          "$terminfo[kf12]"
	'Insert'       "$terminfo[kich1]"
	'Home'         "$terminfo[khome]"
	'PageUp'       "$terminfo[kpp]"
	'End'          "$terminfo[kend]"
	'PageDown'     "$terminfo[knp]"
	'Up'           "$terminfo[kcuu1]"
	'Left'         "$terminfo[kcub1]"
	'Down'         "$terminfo[kcud1]"
	'Right'        "$terminfo[kcuf1]"
	'BackTab'      "$terminfo[kcbt]"
)

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

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
	if [[ -z "$key_info[$key]" ]]; then
		key_info[$key]='�'
	fi
done

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Enable terminal application mode.
# Update editor information when the keymap changes.
function zle-line-init() zle-keymap-select() {
	zle reset-prompt
	# '-R' interprets the in-strings as ranges
	zle -R
}
zle -N zle-line-init
zle -N zle-keymap-select

# Unbound keys in vicmd and viins mode will cause really odd things
# to happen such as the casing of all the characters you have typed
# changing or other undefined things, press 'i' twice to enter
# insert mode again.
function _widget-noop() {  ; }
zle -N _widget-noop

# Keybinds for Vi modes.
for keymap in vicmd; do
	# Edit command in an external editor emacs style (v is used for visual mode)
	bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]E" edit-command-line

	# Undo/Redo
	bindkey -M "$keymap" "u" undo
	bindkey -M "$keymap" "$key_info[Control]R" redo

	if (( $+widgets[history-incremental-pattern-search-backward] )); then
		bindkey -M "$keymap" "?" history-incremental-pattern-search-backward
		bindkey -M "$keymap" "/" history-incremental-pattern-search-forward
	else
		bindkey -M "$keymap" "?" history-incremental-search-backward
		bindkey -M "$keymap" "/" history-incremental-search-forward
	fi

	# Toggle comment at the start of the line.
	bindkey -M "$keymap" "#" vi-pound-insert

	for unbound_key in $unbound_keys; do
		bindkey -M "$keymap" "$unbound_key" _widget-noop
	done

	bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
	bindkey -M "$keymap" "$key_info[End]" end-of-line

	# Delete key deletes character in Vi command mode instead of weird default functionality
	bindkey -M "$keymap" "$key_info[Delete]" delete-char
	
done

# Keybinds for Vi insert mode.
for keymap in viins; do
	
	for unbound_key in $unbound_keys; do
		bindkey -M "$keymap" "$unbound_key" _widget-noop
	done

	bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
	bindkey -M "$keymap" "$key_info[End]" end-of-line

	bindkey -M "$keymap" "$key_info[Insert]" overwrite-mode
	bindkey -M "$keymap" "$key_info[Delete]" delete-char
	bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char

	bindkey -M "$keymap" "$key_info[Left]" backward-char
	bindkey -M "$keymap" "$key_info[Right]" forward-char

	# Expand history on space.
	bindkey -M "$keymap" ' ' magic-space

	# Clear screen.
	bindkey -M "$keymap" "$key_info[Control]L" clear-screen

	# Expand command name to full path.
	for key in "$key_info[Escape]"{E,e}
		bindkey -M "$keymap" "$key" expand-cmd-path

	# Duplicate the previous word.
	for key in "$key_info[Escape]"{M,m}
		bindkey -M "$keymap" "$key" copy-prev-shell-word

done

unset keymap
