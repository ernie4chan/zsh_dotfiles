# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./fzf/init.zsh
#
# Make fuzzy file finder fun!
#
# Author: Ernie Lin
# Update: 2025/03/29
# ---------------------------------------------------------

# Exit if 'fzf' is not found.
(( $+commands[fzf] )) || return 1

# Determine the fzf installation path based on the OS.
case "$(uname -s)" in
    Linux)  
        fzf_bin_path="/usr/bin"
        fzf_shell_path="/usr/share/doc/fzf/examples"
        ;;
    Darwin) 
        fzf_bin_path="/usr/local/opt/fzf/bin"
        fzf_shell_path="/usr/local/opt/fzf/shell"
        ;;
    *)      
        return 1  # Exit if neither Linux nor macOS
        ;;
esac

# Ensure fzf binary path is in $PATH.
[[ ":$PATH:" != *":$fzf_bin_path:"* ]] && export PATH+=":$fzf_bin_path"

# Load fzf auto-completion and key bindings in interactive shells.
if [[ $- == *i* ]]; then
    [[ -r "$fzf_shell_path/completion.zsh" ]] && source "$fzf_shell_path/completion.zsh"
    [[ -r "$fzf_shell_path/key-bindings.zsh" ]] && source "$fzf_shell_path/key-bindings.zsh"
fi