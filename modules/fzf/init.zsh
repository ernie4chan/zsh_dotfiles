# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/fzf/init.zsh
# Title: Make fuzzy file finder fun!
# Maintainer: Ernie Lin
# Update:
#	20250329
#	20260512
# ---------------------------------------------------------

# Abort if fzf is not installed/available.
(( $+commands[fzf] )) || return 1

# Set fzf shell scripts path based on the current OS.
case "$(uname -s)" in
    Linux)  fzf_shell_path="/usr/share/fzf" ;;
    Darwin) fzf_shell_path="/usr/local/opt/fzf/shell" ;;
    *)      return 1 ;;
esac

# Optional: set your preferred fzf defaults here.
_fzf_opts="--height=70% --layout=default --border=rounded"
export FZF_CTRL_T_OPTS="$_fzf_opts"
export FZF_CTRL_R_OPTS="$_fzf_opts"
export FZF_ALT_C_OPTS="--height=20% --margin=0,40%,0,5% --layout=default --border=rounded --info=hidden"
unset _fzf_opts

# Source fzf tab completion if the file exists and is readable.
# Source fzf key bindings (Ctrl+R, Ctrl+T, Alt+C) if the file exists and is readable.
[[ -r "$fzf_shell_path/completion.zsh" ]]    && source "$fzf_shell_path/completion.zsh"
[[ -r "$fzf_shell_path/key-bindings.zsh" ]]  && source "$fzf_shell_path/key-bindings.zsh"
