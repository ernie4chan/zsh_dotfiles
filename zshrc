# vim: noet sw=2 sts=2 ts=2 ft=zsh
#
# Failsafe test purposes and debugging.
#zsh -x 2> ${HOME}/zsh-error.log

# Show an illustrative output on Zsh startup loading. 
#zmodload zsh/zprof

# Set input mode before loading the module.
bindkey -v

# Load and initialize the completion system ignoring insecure directories
# with a cache time of a day.
autoload -Uz compinit
_comp_files=$HOME/.zcompdump(Nm-24)
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

# Load 'pmodload'.
if [[ -s "$HOME/.zsh/pmodload.zsh" ]]; then
  source "$HOME/.zsh/pmodload.zsh"
fi

# Color output (auto set to 'no' on dumb terminals).
zstyle ':zmodule:*:*' color 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':zmodule:*:*' case-sensitive 'yes'

# GNU core utility: set the command prefix on non-GNU systems.
zstyle ':zmodule:gnu-utility' prefix 'g'

# SSH.
#zstyle ':zmodule:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

# Tmux.
zstyle ':zmodule:tmux:auto-start' local 'yes'										# Launch Tmux
zstyle ':zmodule:tmux:auto-start' remote 'yes'									# Launch Tmux in SSH connections
zstyle ':zmodule:tmux:iterm' integrate 'no'											# Integrate iTerm2
zstyle ':zmodule:tmux:session' name 'ernie4chan'								# Default session name
# Completions.
zstyle ':zmodule:completion:*:hosts' etc-host-ignores '0.0.0.0' '127.0.0.1'	# Set entries to ignore

# Autosuggestions.
#zstyle ':zmodule:autosuggestions:color' found ''								# Set colors

# History substring search.
#zstyle ':zmodule:history-substring-search:color' found ''			# Set colors
#zstyle ':zmodule:history-substring-search:color' not-found ''	# Set colors for not found
#zstyle ':zmodule:history-substring-search' globbing-flags ''		# Set search globbing flags

# Syntax highlighters.
#zstyle ':zmodule:syntax-highlighting' highlighters \
#   'main' 'brackets' 'pattern' 'line' 'cursor' 'root'					# Enable main highlighters
#zstyle ':zmodule:syntax-highlighting' styles \
#   'builtin' 'bg=blue' 'command' 'bg=blue' 'function' 'bg=blue'	# Set highlighting styles
#zstyle ':zmodule:syntax-highlighting' pattern \
#   'rm*-rf*' 'fg=white,bold,bg=red'														# Set syntax patterns

# Load all the modules you want!
zstyle ':zmodule:load' pmodule \
	'environment' \
	'power_theme' \
	'private_tokens' \
	'gnu_utility' \
	'aliases' \
	'iterm2_integration' \
	'autosuggestions' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search' \
	'gpg' \
	'tmux'

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':zmodule:*:*' color 'no'
  #zstyle ':prezto:module:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':zmodule:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':zmodule:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Load modules.
zstyle -a ':zmodule:load' pmodule 'pmodules'
pmodload "$pmodules[@]"
unset pmodules
