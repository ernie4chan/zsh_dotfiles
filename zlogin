# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: .zlogin
#
# Executes commands at login post-zshrc.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Execute code that does not affect the current session in the background.
{
	# Compile the completion dump to increase startup speed.
	zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

	if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
		zcompile "$zcompdump"
	fi

} &!

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {
	# Print a random, hopefully interesting, adage.
	if (( $+commands[fortune] )); then
		fortune -s
		print
	fi

} >&2
