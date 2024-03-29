# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./syn_highlight/init.zsh
#
# Integrates Syntax-Highlighting.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Return if requirements are not found.
if ! zstyle -T ':e4czmod:module:syntax-highlighting' color; then
	return 1
fi

# Source module files.
source "${0:h}/external/zsh-syntax-highlighting.zsh" || return 1

# Set highlighters.
zstyle -a ':e4czmod:module:syntax-highlighting' highlighters 'ZSH_HIGHLIGHT_HIGHLIGHTERS'

if (( ${#ZSH_HIGHLIGHT_HIGHLIGHTERS[@]} == 0 )); then
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
fi

# Set highlighting styles.
typeset -A syntax_highlighting_styles
zstyle -a ':e4czmod:module:syntax-highlighting' styles 'syntax_highlighting_styles'

for syntax_highlighting_style in "${(k)syntax_highlighting_styles[@]}"; do
	ZSH_HIGHLIGHT_STYLES[$syntax_highlighting_style]="$syntax_highlighting_styles[$syntax_highlighting_style]"
done
unset syntax_highlighting_style{s,}

# Set pattern highlighting styles.
typeset -A syntax_pattern_styles
zstyle -a ':e4czmod:module:syntax-highlighting' pattern 'syntax_pattern_styles'

for syntax_pattern_style in "${(k)syntax_pattern_styles[@]}"; do
	ZSH_HIGHLIGHT_PATTERNS[$syntax_pattern_style]="$syntax_pattern_styles[$syntax_pattern_style]"
done
unset syntax_pattern_style{s,}
