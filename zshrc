#!/usr/local/bin/zsh

# Failsafe test purposes and debugging.
#zsh -x 2> ${HOME}/zsh-error.log

# Show an illustrative output on Zsh startup loading. 
#zmodload zsh/zprof

# Set input mode before loading the module.
bindkey -v

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

# Completions.
zstyle ':zmodule:completion:*:hosts' etc-host-ignores '0.0.0.0' '127.0.0.1'	# Set entries to ignore

# Autosuggestions.
#zstyle ':zmodule:autosuggestions:color' found ''											# Set colors

# History substring search.
#zstyle ':zmodule:history-substring-search:color' found ''						# Set colors
#zstyle ':zmodule:history-substring-search:color' not-found ''				# Set colors for not found
#zstyle ':zmodule:history-substring-search' globbing-flags ''					# Set search globbing flags

# SSH.
zstyle ':zmodule:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

# Syntax highlighters.
 zstyle ':zmodule:syntax-highlighting' highlighters \
   'main' 'brackets' 'pattern' 'line' 'cursor' 'root'								# Enable main highlighters
zstyle ':zmodule:syntax-highlighting' styles \
   'builtin' 'bg=blue' 'command' 'bg=blue' 'function' 'bg=blue'			# Set highlighting styles
zstyle ':zmodule:syntax-highlighting' pattern \
   'rm*-rf*' 'fg=white,bold,bg=red'																	# Set syntax patterns

# Tmux.
zstyle ':zmodule:tmux:auto-start' local 'yes'												# Launch Tmux
zstyle ':zmodule:tmux:auto-start' remote 'yes'											# Launch Tmux in SSH connections
zstyle ':zmodule:tmux:iterm' integrate 'no'													# Integrate iTerm2
zstyle ':zmodule:tmux:session' name 'ernie4chan'										# Default session name

# Load all the modules you want!
zmodules=(
	gnu_utility
	aliases
	power_theme
	private_tokens
	iterm2_integration
	autosuggestions
	hist_sub_search
	completions
	tmux
)

# Let's put some of the functions from those modules into action.
() {
	setopt LOCAL_OPTIONS EXTENDED_GLOB
	local mod_function
	local function_glob='^([_.]*|prompt_*_setup|README*|*~)(-.N:t)'

	# Autoload searches fpath for function locations.
	fpath=(${HOME}/.zsh/modules/${^zmodules}/functions(/FN) ${fpath})

	for mod_function in ${HOME}/.zsh/modules/${^zmodules}/functions/${~function_glob}; do
		autoload -Uz ${mod_function}
	done
}

# Let's put those modules into action.
() {
	local zmodule zmodule_dir zmodule_file

	for zmodule in ${zmodules}; do
		zmodule_dir=${HOME}/.zsh/modules/${zmodule}
		if [[ ! -d ${zmodule_dir} ]]; then
			print "Module \"${zmodule}\" not available." >&2
		else
			for zmodule_file in ${zmodule_dir}/init.zsh \
				${zmodule_dir}/{,zsh-}${zmodule}.{zsh,plugin.zsh,zsh-theme,sh}; do
				if [[ -f ${zmodule_file} ]]; then
					source ${zmodule_file}
					break
				fi
			done
		fi
	done
}
