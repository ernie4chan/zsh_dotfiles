# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/highlighting/init.zsh
# Title: Integrating Syntax-Highlighting.
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------


# Return if color is disabled or plugin missing.
zstyle -T ':e4czmod:module:syntax-highlighting' color || return 1

# Source module files.
source "${0:h}/external/zsh-syntax-highlighting.zsh" || return 1

# Set highlighters (default: main).
zstyle -a ':e4czmod:module:syntax-highlighting' highlighters 'ZSH_HIGHLIGHT_HIGHLIGHTERS'
(( ${#ZSH_HIGHLIGHT_HIGHLIGHTERS[@]} == 0 )) && ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Apply highlight styles and patterns from zstyle into ZSH_HIGHLIGHT_*.
_zsh_hl_apply() {
    local -A _styles
    zstyle -a ':e4czmod:module:syntax-highlighting' $1 '_styles'
    [[ ${#_styles[@]} -gt 0 ]] && {
        typeset -gA $2
        set -A $2 "${(kv)_styles[@]}"
    }
}

_zsh_hl_apply styles   ZSH_HIGHLIGHT_STYLES
_zsh_hl_apply pattern  ZSH_HIGHLIGHT_PATTERNS
unfunction _zsh_hl_apply
