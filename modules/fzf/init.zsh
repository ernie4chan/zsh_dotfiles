# Add fzf path.
#if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
#  export PATH="$PATH:/usr/local/opt/fzf/bin"
#fi

if [[ ! "$PATH" == */usr/share/fzf* ]]; then
  export PATH="$PATH:/usr/share/fzf"
fi

# Use ~~ as the trigger sequence instead of the default **.
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command.
export FZF_COMPLETION_OPTS='+c -x'

# Changing the layout.
export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"

# Use default commands by default.
#export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
#	find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
#	sed s/^..//) 2> /dev/null'

# Use 'ripgrep' by default.
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'

# Configure fzf in command line.
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[[ $- == *i* ]] && source "/usr/share/fzf/key-bindings.zsh" 2> /dev/null
