# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: .zlogin
#
# Executes commands at login post-'.zshrc'.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Execute code that does not affect the current session in the background.
{
# Compile the completion dump to increase startup speed.
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
if [[ -s "$_comp_path" && (! -s "${_comp_path}.zwc" || "$_comp_path" -nt "${_comp_path}.zwc") ]]; then
		zcompile "$_comp_path"
fi
unset _comp_path
} &!
