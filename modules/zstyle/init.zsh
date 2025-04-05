# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: ./modules/zstyle
#
# Zsh Style Table.
#
# Author: Ernie Lin
# Update: 2025/04/01
# ---------------------------------------------------------

# {{{ --- Prompt ---

# Set the prompt theme to load.
zstyle ':e4czmod:module:prompt' theme 'p10k-1'

# Set the working directory prompt display length.
# By default, it is set to 'short'. Set it to 'long' (without '~' expansion)
# for longer or 'full' (with '~' expansion) for even longer prompt display.
#zstyle ':e4czmod:module:prompt' pwd-length 'short'

# Set the prompt to display the return code along with an indicator for
# non-zero return codes. This is not supported by all prompts.
#zstyle ':e4czmod:module:prompt' show-return-val 'yes'

# }}}

# {{{ --- General ---

# Color output (auto set to 'no' on dumb terminals).
zstyle ':e4czmod:*:*' color 'yes' 

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':e4czmod:*:*' case-sensitive 'yes'

# Allow module overrides when pmodule-dirs causes module name collisions.
#zstyle ':e4czmod:load' pmodule-allow-overrides 'yes'

# Set the zsh modules to load (man zshmodules).
#zstyle ':e4czmod:load' zmodule 'attr'

# Set the zsh functions to load (man zshcontrib).
#zstyle ':e4czmod:load' zfunction 'zargs' 'zmv'

# Add additional directories to be loaded.
#zstyle ':e4czmod:load' pmodule-dirs $HOME/.zshcontrib

# }}}

# {{{ --- History Size ---

# Set the maximum  number  of  events  stored  in  the  internal history list.
zstyle ':e4czmod:enviromment:history' histsize 10000

# Set the maximum number of history events to save in the history file.
zstyle ':e4czmod:enviromment:history' savehist 50000

# }}}

# {{{ --- Editor ---

# Set the characters that are considered to be part of a word.
zstyle ':e4czmod:module:editor' wordchars '*?_-.[]~&;!#$%^(){}<>'

# Auto convert .... to ../..
zstyle ':e4czmod:module:editor' dot-expansion 'yes'

# Allow the zsh prompt context to be shown.
#zstyle ':e4czmod:module:editor' ps-context 'yes'

# }}}

# {{{ --- Utility ---

# Enabled safe operations
zstyle ':e5czmod:module:aliases' safe-ops 'yes'

# To disable all spelling corrections.
zstyle ':e4czmod:module:aliases' correct 'no'

# To disable 'ls' color.
zstyle ':e4czmod:module:aliases:ls' color 'yes'

# To disable GNU coreutils 'ls' to list directories grouped first.
zstyle ':e4czmod:module:aliases:ls' dirs-first 'yes'

# To disable 'grep' highlighting.
zstyle ':e4czmod:module:aliases:grep' color 'yes'

# }}}

# {{{ --- SSH ---

# SSH.
zstyle ':e4czmod:module:ssh:load' identities 'id_rsa' 'id_ed25519' 'id_github'

# }}}

# {{{ --- Tmux ---

# Default session name.
zstyle ':e4czmod:module:tmux:session' name 'tmux'

# Launch Tmux.
zstyle ':e4czmod:module:tmux:auto-start' local 'no'

# Launch Tmux in SSH connections.
zstyle ':e4czmod:module:tmux:auto-start' remote 'no'

# }}}

# {{{ --- Completions ---

# Set the entries to ignore in static */etc/hosts* for host completion.
zstyle ':e4czmod:module:completion:*:hosts' etc-host-ignores \
	'0.0.0.0' '127.0.0.1'

# }}}

# {{{ --- Syntax Highlighters ---

#  By default, only the main highlighter is enabled.
zstyle ':e4czmod:module:syntax-highlighting' highlighters \
	'main' 'brackets' 'pattern' 'line' 'cursor' 'root'

#  Set syntax highlighting styles.
zstyle ':e4czmod:module:syntax-highlighting' styles \
	'builtin' 'fg=green' \
	'command' 'fg=green' \
	'function' 'fg=green'

#  Set syntax pattern styles.
zstyle ':e4czmod:module:syntax-highlighting' pattern \
	'rm*-rf*' 'fg=white,bold,bg=red'

# }}}

# {{{ --- History Substring Search ---

# Set the query found color.
zstyle ':e4czmod:module:history-substring-search:color' found \
	'bg=magenta,fg=white,bold'

# Set the query not-found color.
zstyle ':e4czmod:module:history-substring-search:color' not-found \
	'bg=red,fg=white,bold'

# Set search globbing flags.
zstyle ':e4czmod:module:history-substring-search' globbing-flags \
	'i'

# Enable search case-sensitivity.
zstyle ':e4czmod:module:history-substring-search' case-sensitive 'yes'

# Enable search for fuzzy matches.
zstyle ':e4czmod:module:history-substring-search' fuzzy 'yes'

# Enable prefixed search.
zstyle ':e4czmod:module:history-substring-search' prefixed 'yes'

# Enable search uniqueness.
zstyle ':e4czmod:module:history-substring-search' unique 'yes'

# }}}

# {{{ --- Autosuggestions ---

# Set the query found color.
zstyle ':e4czmod:module:autosuggestions:color' found \
	'fg=8'

# }}}