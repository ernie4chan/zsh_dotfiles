# Add fzf path.
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Use ~~ as the trigger sequence instead of the default **.
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command.
#export FZF_COMPLETION_OPTS='+c -x'

# Changing the layout.
export FZF_DEFAULT_OPTS="--height=40% --reverse --preview='file {}' --preview-window down:1"

# Use 'ripgrep' by default.
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
	find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
	sed s/^..//) 2> /dev/null'

# Configure fzf in command line.
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
