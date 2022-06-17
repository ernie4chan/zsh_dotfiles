# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./hist_sub_search/init.zsh
#
# Integrates History-Substring-Search.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Source module files.
if (( ! $+functions[history-substring-search-up] )); then
	source "${0:h}/external/zsh-history-substring-search.zsh" || return 1
fi

# Search.
zstyle -s ':e4czmod:module:history-substring-search:color' found \
	'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND' || \
	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'

zstyle -s ':e4czmod:module:history-substring-search:color' not-found \
	'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND' || \
	HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

zstyle -s ':e4czmod:module:history-substring-search' globbing-flags \
	'HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS' || \
	HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

if zstyle -T ':e4czmod:module:history-substring-search' case-sensitive; then
	HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="${HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS//i}"
fi

if ! zstyle -T ':e4czmod:module:history-substring-search' color; then
	unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
fi

# Keybindings.
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

bindkey -M viins "[Up]" history-substring-search-up
bindkey -M viins "[Down]" history-substring-search-down
