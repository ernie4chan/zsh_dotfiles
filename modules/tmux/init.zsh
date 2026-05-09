# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/tmux/init.zsh
# Title: Auto launching Tmux at start-up.
# Maintainer: Ernie Lin
# Update:
#	20220610
#	20260509
# ---------------------------------------------------------

# Return if tmux is not installed.
(( $+commands[tmux] )) || return 1

# Integrate with iTerm2.
if [[ "$LC_TERMINAL" == 'iTerm2' ]] && \
    zstyle -t ':e4czmod:module:tmux:iterm' integrate; then
    _tmux_iterm_integration='-CC'
fi

# Auto-start tmux.
if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$INSIDE_EMACS" && "$TERM_PROGRAM" != "vscode" ]] && ( \
	( [[ -n "$SSH_TTY" ]] && zstyle -t ':e4czmod:module:tmux:auto-start' remote ) ||
	( [[ -z "$SSH_TTY" ]] && zstyle -t ':e4czmod:module:tmux:auto-start' local ) \
); then
	tmux start-server

	# Create session if nothing has been defined in tmux config.
	if ! tmux has-session 2> /dev/null; then
		zstyle -s ':e4czmod:module:tmux:session' name tmux_session || tmux_session='0'
		tmux \
			new-session -d -s "$tmux_session" \; \
			set-option -t "$tmux_session" destroy-unattached off &> /dev/null
        unset tmux_session
	fi

	# Attach to the session or to the last session used (detach first).
	exec tmux $_tmux_iterm_integration attach-session -d
fi

# Aliases.
alias tmux="tmux -u -f $HOME/.zsh/tmuxrc"
alias tmuxa="tmux $_tmux_iterm_integration new-session -A"
alias tmuxl="tmux list-sessions"
