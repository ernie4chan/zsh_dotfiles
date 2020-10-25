# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Defines tmux aliases and provides for auto launching it at start-up.
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
	return 1
fi

# Autostart
if ([[ "$TERM_PROGRAM" = 'iTerm.app' ]] && \
	zstyle -t ':zmodule:tmux:iterm' integrate \
	); then
	_tmux_iterm_integration='-CC'
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$INSIDE_EMACS" && "$TERM_PROGRAM" != "vscode" ]] && ( \
	( [[ -n "$SSH_TTY" ]] && zstyle -t ':zmodule:tmux:auto-start' remote ) ||
	( [[ -z "$SSH_TTY" ]] && zstyle -t ':zmodule:tmux:auto-start' local ) \
	); then
	tmux start-server

	# Create a 'Hello' session if no session has been defined in tmux.conf.
	if ! tmux has-session 2> /dev/null; then
		zstyle -s ':zmodule:tmux:session' name tmux_session || tmux_session='Hello'
		tmux \
			new-session -d -s "$tmux_session" \; \
			set-option -t "$tmux_session" destroy-unattached off &> /dev/null
	fi

	# Attach to the 'Hello' session or to the last session used. (detach first)
	exec tmux $_tmux_iterm_integration attach-session -d
fi

# Aliases
alias tmuxa="tmux $_tmux_iterm_integration new-session -A"
alias tmuxl='tmux list-sessions'
