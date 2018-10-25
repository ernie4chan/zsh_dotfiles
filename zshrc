# vim: noet sw=2 sts=2 ts=2 ft=zsh
#
# Failsafe test purposes and debugging.
#zsh -x 2> ${HOME}/zsh-error.log

# Show an illustrative output on Zsh startup loading. 
zmodload zsh/zprof

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

# Load all the modules you want!
zmodules=(
	zstyles
	gnu_utility
	aliases
	power_theme
	private_tokens
	iterm2_integration
	autosuggestions
	completions
	syn_highlight
	hist_sub_search
	ssh
	gpg
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
