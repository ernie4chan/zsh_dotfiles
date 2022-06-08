# vim: ts=4 ft=zsh
#
# zstyle Table.
#

# {{{ --- Terminal. ---

# Disable color and theme in dumb terminals.
if [[ "$TERM" == (dumb|linux|*bsd*) ]]; then
	# Auto set to 'off' on dumb terminals.
	zstyle ':e4czmod:*:*' color 'no'
	zstyle ':e4czmod:module:prompt' theme 'off'
else
	# Color output (auto set to 'no' on dumb terminals).
	zstyle ':e4czmod:*:*' color 'yes'
	# Set the prompt theme to load.
	zstyle ':e4czmod:module:prompt' theme 'powerlevel10k'
fi

# }}}

# {{{ --- Utility. ---

# Set the working directory prompt display length: 'short', 'long', and 'full'.
#zstyle ':e4czmod:module:prompt' pwd-length 'short'

# Set the prompt to display the return code.
#zstyle ':e4czmod:module:prompt' show-return-val 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':e4czmod:*:*' case-sensitive 'no'

# Add additional directories to be loaded.
#zstyle ':e4czmod:load' pmodule-dirs $HOME/.zshcontrib

# Allow module overrides when pmodule-dirs causes module name collisions.
zstyle ':e4czmod:load' pmodule-allow-overrides 'yes'

# Set the ZSH modules to load (man zshmodules).
zstyle ':e4czmod:load' zmodule 'attr' 'stat'

# Set the ZSH functions to load (man zshcontrib).
#zstyle ':e4czmod:load' zfunction 'zargs' 'zmv'

# SSH.
zstyle ':e4czmod:module:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

# Enabled safe operations
zstyle ':e4czmod:module:aliases' safe-ops 'no'

# To disable all spelling corrections.
zstyle ':e4czmod:module:aliases' correct 'yes'

# To disable 'ls' color.
zstyle ':e4czmod:module:aliases:ls' color 'yes'

# To disable GNU coreutils 'ls' to list directories grouped first.
zstyle ':e4czmod:module:aliases:ls' dirs-first 'yes'

# To disable 'grep' highlighting.
zstyle ':e4czmod:module:aliases:grep' color 'yes'

# Set the command prefix on non-GNU systems.
#zstyle ':e4czmod:module:gnu-utility' prefix 'g'

# }}}

# {{{ --- Editor. ---

# Key mapping style to 'emacs' or 'vi'.
zstyle ':e4czmod:module:editor' key-bindings 'vi'

# Auto convert .... to ../..
zstyle ':e4czmod:module:editor' dot-expansion 'no'

# Allow to show ZSH prompt context.
zstyle ':e4czmod:module:editor' ps-context 'no'

# }}}

# {{{ --- Tmux. ---

# Default session name.
zstyle ':e4czmod:module:tmux:session' name 'tmux'

# Launch Tmux.
zstyle ':e4czmod:module:tmux:auto-start' local 'yes'

# Launch Tmux in SSH connections.
zstyle ':e4czmod:module:tmux:auto-start' remote 'no'

# Integrate iTerm2.
zstyle ':e4czmod:module:tmux:iterm' integrate 'no'

# }}}

# {{{ --- Completions. ---

# Set the entries to ignore in static */etc/hosts* for host completion.
zstyle ':e4czmod:module:completion:*:hosts' etc-host-ignores \
	'0.0.0.0' '127.0.0.1'

# }}}

# {{{ --- Syntax Highlighters. ---

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

# {{{ --- History Substring Search. ---

# Set the query found color.
zstyle ':e4czmod:module:history-substring-search:color' found \
	'bg=magenta,fg=white,bold'

# Set the query not-found color.
zstyle ':e4czmod:module:history-substring-search:color' not-found \
	'bg=red,fg=white,bold'

# Set search globbing flags.
zstyle ':e4czmod:module:history-substring-search' globbing-flags \
	'i'

# }}}

# {{{ --- Autosuggestions. ---

# Set the query found color.
zstyle ':e4czmod:module:autosuggestions:color' found \
	'fg=8'

# }}}
