# ---------------------------------------------------------
# vim: ts=4 ft=zsh
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
