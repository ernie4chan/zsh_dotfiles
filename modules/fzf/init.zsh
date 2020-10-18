# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Make fuzzy file finder fun!
#

# Return if requirements are not found.
(( ! $+commands[fzf] )) && return 1

# Load dependencies.
pmodload 'helper'

# Add fzf path.
if is-darwin; then
	if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
		export PATH="$PATH:/usr/local/opt/fzf/bin"
	fi
elif is-linux; then
	if [[ ! "$PATH" == */usr/share/fzf* ]]; then
		export PATH="$PATH:/usr/share/fzf"
	fi
fi

# Options to fzf command.
export FZF_COMPLETION_OPTS='+c -x'

# Changing the layout.
export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"

# Use 'ripgrep' by default.
if [[ -s $(which rg) ]]; then
	export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
else
	export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
		find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
		sed s/^..//) 2> /dev/null'
fi

# Configure fzf in command line.
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[[ $- == *i* ]] && source "/usr/share/fzf/key-bindings.zsh" 2> /dev/null
