# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/hist_sub_search/init.zsh
# Title: Integrating History-Substring-Search.
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------

# Source module files.
(( ! $+functions[history-substring-search-up] )) && \
    source "${0:h}/external/zsh-history-substring-search.zsh" || return 1

# Search colors.
zstyle -s ':e4czmod:module:history-substring-search:color' found \
    'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND' || \
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
zstyle -s ':e4czmod:module:history-substring-search:color' not-found \
    'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND' || \
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# Search options.
zstyle -s ':e4czmod:module:history-substring-search' globbing-flags \
    'HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS' || \
    HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
zstyle -T ':e4czmod:module:history-substring-search' case-sensitive && \
    HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="${HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS//i}"
zstyle -T ':e4czmod:module:history-substring-search' color || \
    unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}

# Keybindings.
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M viins "$key_info[Up]"   history-substring-search-up
bindkey -M viins "$key_info[Down]" history-substring-search-down
