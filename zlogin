# ---------------------------------------------------------
# vim: ft=zsh
#
# File: .\zlogin
#
# Executes commands at login post-'.zshrc'.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Remove unwated init files.
#_unwanted_file="${HOME}/.zcompdump"
#if [[ -f "$_unwanted_file" ]]; then
	#command rm "$_unwanted_file"
#fi
#unset _unwanted_file

{
    # Define zcompdump path
    zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

    # Compile zcompdump if needed
    command mkdir "${zcompdump}.zwc.lock" 2>/dev/null && \

    [[ -s $zcompdump && (! -s ${zcompdump}.zwc || $zcompdump -nt ${zcompdump}.zwc) ]] && \
    zcompile "$zcompdump"

    command rmdir "${zcompdump}.zwc.lock" 2>/dev/null
} &!