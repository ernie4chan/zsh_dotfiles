# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/fzf/init.zsh
# Title: Make fuzzy file finder fun!
# Maintainer: Ernie Lin
# Update:
#	20250329
#	20260512
# ---------------------------------------------------------

# Set fzf shell scripts path based on the current OS.
case "$(uname -s)" in
    Linux)  _fzf_shell_path="/usr/share/fzf" ;;
    Darwin) _fzf_shell_path="/usr/local/opt/fzf/shell" ;;
    *)      return 1 ;;
esac

# Source fzf tab completion and key bindings if not already loaded.
(( ! $+functions[fzf-completion] )) && {
for f in completion.zsh key-bindings.zsh; do
    [[ -r "$_fzf_shell_path/$f" ]] && source "$_fzf_shell_path/$f"
done
}

# Optional: set your preferred fzf defaults here.
_fzf_opts="--layout=default --border=rounded --height=70%"
export FZF_CTRL_T_OPTS="$_fzf_opts"
export FZF_CTRL_R_OPTS="$_fzf_opts"
export FZF_ALT_C_OPTS="$_fzf_opts --height=20% --margin=0,40%,0,5% --info=hidden"

unset _fzf_shell_path _fzf_opts
