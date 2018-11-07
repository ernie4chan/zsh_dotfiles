# Add fzf path.
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Use 'ripgrep' by default.
export FZF_DEFAULT_COMMAND="rg --color=never --files --hidden -g '*' -g '!.git/'"

# Changing the layout.
export FZF_DEFAULT_OPTS="--height=40% --preview='cat {}' --preview-window=right:60%:wrap"

# Configure fzf in command line.
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
