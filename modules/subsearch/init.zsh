# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/subsearch/init.zsh
# Title: Integrating History-Substring-Search.
# Maintainer: Ernie Lin
# Update:
#   20220610
#   20260509
# ---------------------------------------------------------

# Source module files.
[[ -f "${0:h}/external/zsh-history-substring-search.zsh" ]] && \
    source "${0:h}/external/zsh-history-substring-search.zsh" || return 1

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

zstyle -t ':e4czmod:module:history-substring-search' case-sensitive && \
    HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="${HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS//i}"

zstyle -t ':e4czmod:module:history-substring-search' color || \
    unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}

zstyle -t ':e4czmod:module:history-substring-search' fuzzy && \
    HISTORY_SUBSTRING_SEARCH_FUZZY=1

zstyle -t ':e4czmod:module:history-substring-search' unique && \
    HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

zstyle -t ':e4czmod:module:history-substring-search' prefixed && \
    HISTORY_SUBSTRING_SEARCH_PREFIXED=1

# Keybindings.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
if (( $+key_info )); then
    bindkey -M viins "$key_info[Up]"   history-substring-search-up
    bindkey -M viins "$key_info[Down]" history-substring-search-down
fi
