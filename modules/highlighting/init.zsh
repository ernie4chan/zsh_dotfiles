# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/highlighting/init.zsh
# Title: zsh-syntax-highlighting
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------

# Return if color is disabled or plugin missing.
zstyle -t ':e4czmod:module:syntax-highlighting' color || return 1

# Source module files.
(( ! $+functions[_zsh_highlight] )) && \
    source "${0:h}/external/zsh-syntax-highlighting.zsh"

# Set highlighters (default: main).
zstyle -a ':e4czmod:module:syntax-highlighting' highlighters \
    'ZSH_HIGHLIGHT_HIGHLIGHTERS'
(( ${#ZSH_HIGHLIGHT_HIGHLIGHTERS[@]} == 0 )) && \
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Apply highlight styles and patterns from zstyle into ZSH_HIGHLIGHT_*.
_zsh_hl_apply() {
    local -A _motif
    zstyle -a ':e4czmod:module:syntax-highlighting' $1 '_motif'
    [[ ${#_motif[@]} -gt 0 ]] && {
        typeset -gA $2
        set -A $2 "${(kv)_motif[@]}"
    }
}

_zsh_hl_apply pattern  ZSH_HIGHLIGHT_PATTERNS
_zsh_hl_apply styles   ZSH_HIGHLIGHT_STYLES
unfunction _zsh_hl_apply
