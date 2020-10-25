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
	[[ ! "$PATH" == */usr/share/fzf* ]] && \
		export PATH="$PATH:/usr/share/fzf"
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/share/fzf/completion.zsh" 2>/dev/null; \
		source "/usr/share/fzf/key-bindings.zsh" 2>/dev/null
elif is-darwin; then
	[[ ! "$PATH" == */usr/local/opt/fzf/bin* ]] && \
		export PATH="$PATH:/usr/local/opt/fzf/bin"
	# Auto-completion and Key-bindings.
	[[ $- == *i* ]] && \
		source "/usr/local/opt/fzf/bin/completion.zsh" 2> /dev/null; \
		source "/usr/local/opt/fzf/bin/key-bindings.zsh" 2> /dev/null
fi

# Use 'ripgrep' by default by pressing <Ctrl-R>.
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore-vcs'
