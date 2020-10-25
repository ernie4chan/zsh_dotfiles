# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Make fuzzy file finder fun!
#

# Return if requirements are not found.
(( ! $+commands[fzf] )) && return 1

# Load dependencies.
pmodload 'helper'

# Add fzf path.
if is-linux; then
	if [[ ! "$PATH" == */usr/share/fzf* ]]; then
		export PATH="$PATH:/usr/share/fzf"
	fi
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/share/fzf/completion.zsh" 2>/dev/null; \
		source "/usr/share/fzf/key-bindings.zsh" 2>/dev/null
elif is-darwin; then
	if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
		export PATH="$PATH:/usr/local/opt/fzf/bin"
	fi
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/local/opt/fzf/bin/completion.zsh" 2> /dev/null; \
		source "/usr/local/opt/fzf/bin/key-bindings.zsh" 2> /dev/null
fi

# Use 'ripgrep' by default by pressing <Ctrl-R>.
if (( $+commands[rg] )); then
	export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore-vcs'
else
	export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
		find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
		sed s/^..//) 2> /dev/null'
fi
