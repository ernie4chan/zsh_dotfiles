#!/usr/bin/env zsh

# Load tmux with specified config file.
if [[ -z $TMUX ]]; then
	tmux start-server
	if ! tmux has-session 2> /dev/null; then
		whoami=$(whoami)
		tmux new-session -d -s "$whoami" \; \
			set-option -t "$whoami" destroy-unattached off &> /dev/null
	fi
	tmux attach-session -d -t "$whoami" &> /dev/null
fi

# Ways to exit.
function quit() {
	if [[ -n $TMUX ]]; then
		osascript -e 'tell application "Terminal" to quit' && \
			tmux kill-server
	else
		builtin exit
	fi
}

function exit() {
	if [[ -n $TMUX ]]; then
		osascript -e 'tell application "Terminal" to quit'
	fi
}
