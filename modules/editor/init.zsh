# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/editor/init.zsh
# Title: Define custom keybindings.
# Maintainer: Ernie Lin
# Update:
#   20250329
#   20260509
# ---------------------------------------------------------

# {{{ --- Check wether dumb terminal ---

[[ "$TERM" == 'dumb' ]] && return 1

# }}}

# {{{ --- Overwrite default identifiers ---

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
    'Control'           '\C-'
    'ControlLeft'       '\e[1;5D \e[5D \e\e[D \eOd'
    'ControlPageDown'   '\e[6;5~'
    'ControlPageUp'     '\e[5;5~'
    'ControlRight'      '\e[1;5C \e[5C \e\e[C \eOc'
    'Escape'            '\e'
    'Meta'              '\M-'
    'BackTab'           "$terminfo[kcbt]"
    'Backspace'         "$terminfo[kbs]"
    'Delete'            "$terminfo[kdch1]"
    'End'               "$terminfo[kend]"
    'Home'              "$terminfo[khome]"
    'Insert'            "$terminfo[kich1]"
    'PageDown'          "$terminfo[knp]"
    'PageUp'            "$terminfo[kpp]"
    'Left'              "$terminfo[kcub1]"
    'Down'              "$terminfo[kcud1]"
    'Up'                "$terminfo[kcuu1]"
    'Right'             "$terminfo[kcuf1]"
    'F1'                "$terminfo[kf1]"
    'F2'                "$terminfo[kf2]"
    'F3'                "$terminfo[kf3]"
    'F4'                "$terminfo[kf4]"
    'F5'                "$terminfo[kf5]"
    'F6'                "$terminfo[kf6]"
    'F7'                "$terminfo[kf7]"
    'F8'                "$terminfo[kf8]"
    'F9'                "$terminfo[kf9]"
    'F10'               "$terminfo[kf10]"
    'F11'               "$terminfo[kf11]"
    'F12'               "$terminfo[kf12]"
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce
# silent bindkey failure.
for key ( ${(k)key_info} ); do
    [[ -z ${key_info[$key]} ]] && key_info[$key]='�'
done

# }}}

# {{{ --- Functions ---

# Treat these characters as part of a word.
zstyle -s ':e4czmod:module:editor' wordchars 'WORDCHARS' \
    || WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Debugging: runs bindkey but for all of the keymaps. Running it with
# no arguments will print out the mappings for all of the keymaps.
function bindkey-all {
    for keymap in ${(f)"$(bindkey -l)"}; do
        (( $# == 0 )) && echo "#### ${keymap}" >&2
        bindkey -M "${keymap}" "$@"
    done
}

# If the buffer already ends with double dots, append a parent directory path.
# Otherwise just add a dot.
function expand-dot-to-parent-directory-path {
    [[ $LBUFFER = *.. ]] && LBUFFER+='/..' || LBUFFER+='.'
}
zle -N expand-dot-to-parent-directory-path

# Expands an alias under the cursor, performs word expansion,
# and inserts a space with history expansion.
function glob-alias {
    zle _expand_alias
    zle expand-word
    zle magic-space
}
zle -N glob-alias

# Displays an indicator when completing (e.g. a spinner or ellipsis).
# Falls back to plain expand-or-complete if no indicator is configured,
# working around a zsh bug with multi-line prompts.
function expand-or-complete-with-indicator {
    local indicator
    zstyle -s ':e4czmod:module:editor:info:completing' format 'indicator'
    if [[ -z "$indicator" ]]; then
        zle expand-or-complete
        return
    fi
    print -Pn "$indicator"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-indicator

# }}}

# {{{ --- Functions overrided by p10k ---

# Define prompt hooks and vi mode widgets only if p10k is not loaded.
# p10k defines its own versions internally; defining them without this
# guard would cause one to clobber the other.
(( ! $+functions[p10k] )) && {

    # --- Editor info ---

    # Exposes information about the Zsh Line Editor via the $editor_info
    # associative array. Sets editor_info[keymap] based on the current vi
    # mode, then resets the prompt to reflect the change.
    function editor-info {
        if zstyle -t ':e4czmod:module:prompt' managed; then
            unset editor_info
            typeset -gA editor_info
            if [[ "$KEYMAP" == 'vicmd' ]]; then
                # Normal/command mode (Escape)
                zstyle -s ':e4czmod:module:editor:info:keymap:command' format 'REPLY'
                editor_info[keymap]="$REPLY"
            elif [[ "$ZLE_STATE" == *overwrite* ]]; then
                # Replace mode (R)
                zstyle -s ':e4czmod:module:editor:info:keymap:replace' format 'REPLY'
                editor_info[keymap]="$REPLY"
            else
                # Insert mode (i, I)
                zstyle -s ':e4czmod:module:editor:info:keymap:insert' format 'REPLY'
                editor_info[keymap]="$REPLY"
            fi
            unset REPLY
            zle zle-reset-prompt
        fi
    }
    zle -N editor-info

    # --- Prompt reset hook ---

    # Reset the prompt if ps-context is unset, or if we are not
    # in a select or cont context.
    function zle-reset-prompt {
        ! zstyle -t ':e4czmod:module:editor' ps-context || \
            [[ $CONTEXT != (select|cont) ]] && { zle reset-prompt; zle -R }
    }
    zle -N zle-reset-prompt

    # --- ZLE lifecycle hooks ---

    # Called automatically by ZLE when the keymap changes (e.g. vi insert <-> normal).
    # Updates editor_info so the prompt can reflect the current mode.
    function zle-keymap-select { zle editor-info }
    zle -N zle-keymap-select

    # Called by ZLE when a new command line is started.
    # Enables terminal application mode (required for valid $terminfo values)
    # and updates editor information.
    function zle-line-init {
        (( $+terminfo[smkx] )) && echoti smkx
        zle editor-info
    }
    zle -N zle-line-init

    # Called by ZLE when a command line is finished (i.e. Enter is pressed).
    # Disables terminal application mode and updates editor information.
    function zle-line-finish {
        (( $+terminfo[rmkx] )) && echoti rmkx
        zle editor-info
    }
    zle -N zle-line-finish

    # --- Vi mode-switching widgets ---

    # Wraps vi mode-switching widgets to call editor-info after each transition,
    # keeping the prompt indicator in sync with the current mode.
    for widget in vi-cmd-mode vi-insert vi-insert-bol vi-replace; do
        function $widget {
            zle .$WIDGET
            zle editor-info
        }
        zle -N $widget
    done

}

# }}}

# {{{ --- vim extended bindkeys ---

# Reset to default bindings then set vi layout.
bindkey -d
bindkey -v

# Expand .... to ../..
if zstyle -t ':e4czmod:module:editor' dot-expansion; then
    bindkey -M viins '.' expand-dot-to-parent-directory-path
fi

# Do not expand .... to ../.. during incremental search.
zstyle -t ':e4czmod:module:editor' dot-expansion && \
    bindkey -M isearch . self-insert 2>/dev/null

# Expand aliases.
bindkey -M viins "$key_info[Control] " glob-alias

# Tab completion with indicator.
bindkey -M viins "$key_info[Control]I" expand-or-complete-with-indicator

# }}}

# {{{ --- Unbound keys ---

# Binds F-keys and Page keys to a no-op in vi modes to prevent undefined behavior
# such as characters changing case or garbage being inserted.
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

# Unbound keys in vicmd and viins mode will cause really odd things to happen
# such as the casing of all the characters you have typed changing or other
# undefined things.
function _prezto-zle-noop {  ; }
zle -N _prezto-zle-noop

for keymap in $unbound_keys; do
    bindkey -M viins "${keymap}" _prezto-zle-noop
    bindkey -M vicmd "${keymap}" _prezto-zle-noop
done

unset unbound_keys

# }}}
