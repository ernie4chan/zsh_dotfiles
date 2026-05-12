# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/zstyle/init.zsh
# Tilte: Zsh Style Table.
# Maintainer: Ernie Lin
# Update:
#	20250401
#	20260509
# ---------------------------------------------------------

# {{{ --- General ---

# Color output (auto set to 'no' on dumb terminals).
zstyle ':e4czmod:*:*' color 'yes'

# Set case-sensitivity for completions, history lookup, etc.
zstyle ':e4czmod:*:*' case-sensitive 'yes'

# Toggle module overrides when pmodule-dirs causes name collisions.
zstyle ':e4czmod:load' pmodule-allow-overrides 'no'

# Load additional directories like prezto modules.
#zstyle ':e4czmod:load' pmodule-dirs $HOME/Descargas/prezto-contrib

# Extra zsh modules to load (man zshmodules).
zstyle ':e4czmod:load' zmodule 'attr'

# Extra zsh functions to load (man zshcontrib).
# Set the zsh functions to load (man zshcontrib).
zstyle ':e4czmod:load' zfunction 'zargs' 'zmv'

# }}}

# {{{ --- History size ---

# Set the file to save the history in when an interactive shell exits.
zstyle ':e4czmod:environment:history' lesshistfile "$HOME/.less_history"

# Set the file to save the history in when an interactive shell exits.
zstyle ':e4czmod:environment:history' histfile "$HOME/.zsh_history"

# Set the maximum number of events stored in the internal history list.
zstyle ':e4czmod:environment:history' histsize 10000

# Set the maximum number of history events to save in the history file.
zstyle ':e4czmod:environment:history' savehist 50000

# }}}

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

# {{{ --- Editor ---

# Set the characters that are considered to be part of a word.
zstyle ':e4czmod:module:editor' wordchars '*?_-.[]~&;!#$%^(){}<>'

# Toggle the zsh prompt context to be shown.
# If p10k is enabled, it will be overwritten anywyas.
zstyle ':e4czmod:module:editor' ps-context 'yes'

# Toggle auto convert .... to ../..
zstyle ':e4czmod:module:editor' dot-expansion 'yes'

# }}}

# {{{ --- Utilities ---

# Toggle some spelling corrections.
zstyle ':e4czmod:module:utilities' correct 'no'

# Toggle safe operations
zstyle ':e4czmod:module:utilities' safe-ops 'yes'

# Toggle 'grep' highlighting.
zstyle ':e4czmod:module:utilities:grep' color 'yes'

# Toggle 'ls' color.
zstyle ':e4czmod:module:utilities:ls' color 'yes'

# Toggle GNU coreutils 'ls' to list directories grouped first.
zstyle ':e4czmod:module:utilities:ls' dirs-first 'yes'

# }}}

# {{{ --- SSH ---

# SSH.
zstyle ':e4czmod:module:ssh:load' identities 'id_rsa' 'id_ed25519' 'id_github'

# }}}

# {{{ --- Completions ---

# Set the entries to ignore in static */etc/hosts* for host completions.
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
zstyle ':e4czmod:module:history-substring-search' globbing-flags 'i'

# Toggle search case-sensitivity.
zstyle ':e4czmod:module:history-substring-search' case-sensitive 'yes'

# Toggle search for fuzzy matches.
zstyle ':e4czmod:module:history-substring-search' fuzzy 'yes'

# Toggle prefixed search.
zstyle ':e4czmod:module:history-substring-search' prefixed 'yes'

# Toggle search uniqueness.
zstyle ':e4czmod:module:history-substring-search' unique 'yes'

# }}}

# {{{ --- Autosuggestions ---

# Set the query found color.
zstyle ':e4czmod:module:autosuggestions:color' found \
	'fg=8'

# }}}
