# Correct commands.
setopt CORRECT

# Disable correction.
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias top='nocorrect sudo htop'     # Run 'sudo' because there are no PROC files in macOS

# Move to Tmux zsh module folder.
alias tmux="nocorrect tmux -f $HOME/.zsh/tmuxrc"      # Load tmux with specific config file

# Disable globbing.
alias find='noglob find'
alias history='noglob history'
alias rsync='noglob rsync'

# Directory aliases.
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias po='popd'
alias pu='pushd'
alias dv='dirs -v'						# List last used directories
for index ({1..9}) alias "d${index}"="cd +${index}"; unset index

# Customize some aliases.
alias b='${(z)BROWSER}'
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias p='${(z)PAGER}'
alias df='df -kh'							# More human readable
alias du='du -kh'							# More human readable
alias ftty='stty sane'				# Restore terminal settings when screwed up
alias pbc='pbcopy'						# macOS console copy
alias pbp='pbpaste'						# macOS console paste
alias ptt='ssh bbsu@ptt.cc'		# Open up BBS: PTT
alias shu='tree -N'						# Fix tree
alias topc='htop --sort-key=PERCENT_CPU'	# Sort with CPU usage
alias topm='htop --sort-key=PERCENT_MEM'	# Sort with MEM usage
alias py3='python3'						# Redifining python3 shell
alias bpy='bpython'						# Redifining python3 shell

# Some sh aliases.
alias mc=". ~/.local/bin/mc-wrapper-zsh.sh"
alias itun=". ~/.local/bin/itunes.sh"

# - ls -
if isCallable 'dircolors'; then
  # GNU utilities

  if zstyle -T ':zmodule:core:utility:ls' dirs-first; then
    alias ls="${aliases[ls]:-ls} --group-directories-first"
  fi

  if zstyle -t ':zmodule:core:utility:ls' color; then
    # Call dircolors to define colors if they're missing
    if [[ -z "$LS_COLORS" ]]; then
      if [[ -s "$HOME/.dir_colors" ]]; then
        eval "$(dircolors --sh "$HOME/.dir_colors")"
      else
        eval "$(dircolors --sh)"
      fi
    fi

    alias ls="${aliases[ls]:-ls} --color=auto"
  else
    alias ls="${aliases[ls]:-ls} -F"
  fi
else
  # BSD utilities
  if zstyle -t ':zmodule:core:utility:ls' color; then
    # Define colors for BSD ls if they're not already defined
    if [[ -z "$LSCOLORS" ]]; then
      export LSCOLORS='exfxcxdxbxGxDxabagacad'
    fi

    # Define colors for the completion system if they're not already defined
    if [[ -z "$LS_COLORS" ]]; then
      export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
    fi

    alias ls="${aliases[ls]:-ls} -G"
  else
    alias ls="${aliases[ls]:-ls} -F"
  fi
fi

if isCallable 'dircolors'; then
	alias ls='ls --group-directories-first --color=auto'
  # Call dircolors to define colors if they're missing.
	if [[ -z $LS_COLORS ]]; then
		if [[ -s $HOME/.dir_colors ]]; then
			eval $(dircolors --sh "$HOME/.dir_colors")
		else
			eval $(dircolors --sh)
		fi
	fi
fi

# - ...more of ls -
alias l='ls -1A'         # Lists in one column, hidden files
alias ll='ls -lh'        # Lists human readable sizes
alias lr='ll -R'         # Lists human readable sizes, recursively
alias la='ll -A'         # Lists human readable sizes, hidden files
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager
alias lx='ll -XB'        # Lists sorted by extension (GNU only)
alias lk='ll -Sr'        # Lists sorted by size, largest last
alias lt='ll -tr'        # Lists sorted by date, most recent last
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time

# - grep -
if zstyle -T ':zmodule:core:utility:grep' color; then
  export GREP_COLOR='37;45'           # BSD.
  export GREP_COLORS="mt=$GREP_COLOR" # GNU.

  alias grep="${aliases[grep]:-grep} --color=auto"
fi

# File download.
if (( $+commands[curl] )); then
	alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
	alias get='wget --continue --progress=bar --timestamping'
fi
