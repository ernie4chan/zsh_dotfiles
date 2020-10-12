# vim: noet sw=2 sts=2 ts=2 ft=zsh

#
# Execute code that does not affect the current session in the background.
#

{
	# Compile the completion dump to increase startup speed.
	zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
	if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
		zcompile "$zcompdump"
	fi
} &!
