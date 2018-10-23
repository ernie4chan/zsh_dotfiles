# Color output (auto set to 'no' on dumb terminals).
if [[ "${TERM}" == 'dumb' ]]; then
  zstyle ':zmodule:*:*' color 'no'
else
	zstyle ':zmodule:*:*' color 'yes'
fi

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':zmodule:*:*' case-sensitive 'yes'

# GNU core utility: set the command prefix on non-GNU systems.
zstyle ':zmodule:gnu-utility' prefix 'g'


# SSH.
zstyle ':zmodule:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

# Tmux.
zstyle ':zmodule:tmux:auto-start' local 'yes'								# Launch Tmux
zstyle ':zmodule:tmux:auto-start' remote 'yes'								# Launch Tmux in SSH connections
zstyle ':zmodule:tmux:iterm' integrate 'no'									# Integrate iTerm2
zstyle ':zmodule:tmux:session' name 'ernie4chan'							# Default session name
# Completions.
zstyle ':zmodule:completion:*:hosts' etc-host-ignores '0.0.0.0' '127.0.0.1'	# Set entries to ignore

# Autosuggestions.
#zstyle ':zmodule:autosuggestions:color' found ''							# Set colors

# History substring search.
#zstyle ':zmodule:history-substring-search:color' found ''					# Set colors
#zstyle ':zmodule:history-substring-search:color' not-found ''				# Set colors for not found
#zstyle ':zmodule:history-substring-search' globbing-flags ''				# Set search globbing flags

# Syntax highlighters.
#zstyle ':zmodule:syntax-highlighting' highlighters \
#   'main' 'brackets' 'pattern' 'line' 'cursor' 'root'						# Enable main highlighters
#zstyle ':zmodule:syntax-highlighting' styles \
#   'builtin' 'bg=blue' 'command' 'bg=blue' 'function' 'bg=blue'			# Set highlighting styles
#zstyle ':zmodule:syntax-highlighting' pattern \
#   'rm*-rf*' 'fg=white,bold,bg=red'										# Set syntax patterns
