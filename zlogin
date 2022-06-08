# vim: ts=4 ft=zsh
#
# Execution in the background when login.
#

{

	# Compile the completion dump to increase startup speed.
	_comp_dumpfile="${XDG_CACHE_HOME:-$HOME.cache}/zsh/zcompdump}"
	if [[ -s "$_comp_dumpfile" && (! -s "${_comp_dumpfile}.zwc" || "$_comp_dumpfile" -nt "${_comp_dumpfile}.zwc") ]]; then
		zcompile "$_comp_dumpfile"
	fi
	unset _comp_dumpfile

} &!
