# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Correct commands.
setopt CORRECT

# Disable correction.
alias mv='nocorrect mv'
alias rm='nocorrect rm'

# Disable globbing.
alias find='noglob find'
alias rsync='noglob rsync'

# Directory aliases.
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias po='popd'
alias pu='pushd'
alias 0='dirs -v'										# List last used directories
for index ({1..9}) alias "${index}"="cd +${index}"; unset index
alias ..='cd ../'										# Go back 1 level
alias ...='cd ../../'								# Go back 2 levels
alias ....='cd ../../../'						# Go back 3 levels

# Customize some aliases.
alias df='df -kh'										# More human readable
alias du='du -kh'										# More human readable
alias ftty='stty sane'							# Restore terminal settings when screwed up
alias lynx="lynx -cfg=$HOME/.config/lynx/lynxrc"
alias myip='echo "Current IP is $(curl -s ifconfig.co)"'	# Public facing IP address
alias mc="SHELL=/bin/bash LANG=en_US.UTF-8 source /usr/lib/mc/mc-wrapper.sh"
alias mutt="mutt -F ~/.local/share/mutt/muttrc"
alias ptt='ssh bbsu@ptt.cc'					# Open up BBS: PTT
alias py3='python3'									# Redifining python3 shell
alias ql="qlmanage -p $@ 2>/dev/null"						# View images
alias tmux="tmux -u -f $HOME/.zsh/tmuxrc"				# Load tmux with specific config file
alias irssi="TERM=screen irssi --home=~/.local/share/irssi"

if [[ "$OSTYPE" == darwin* ]]; then
	alias ofd='open .'									# Open current directory in Finder
	alias sfd='sync_with_finder'				# Sync current directory in Terminal
	alias shu='tree -N'									# Fix tree
	alias inject="diskutil mount $@"		# Mount external devices
	alias eject="diskutil unmount $@"		# Unmount external devices
# Search files using macOS Spotlight's metadata:
# w: the comparison is word-based and detects transitions from lower-case to upper-case.
# c: the comparison is case insensitive.
	locate () { mdfind "kMDItemDisplayName == '$@'wc"; }
fi

# - ls -
if isCallable 'dircolors'; then
# GNU utilities
  if zstyle -T ':zmodule:core:utility:ls' dirs-first; then
    alias ls="${aliases[ls]:-ls} --group-directories-first"
  fi
  if zstyle -t ':zmodule:core:utility:ls' color; then
# Call dircolors to define colors if they are missing
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

# - ...more of ls -
alias l1='ls -1'				 # Lists in one column
alias l2='ls -1A'        # Lists in one column, hidden files
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
  export GREP_COLOR='37;45'											# BSD
  export GREP_COLORS="mt=$GREP_COLOR"						# GNU
  alias grep="${aliases[grep]:-grep} --color=auto"
  alias egrep="${aliases[egrep]:-egrep} --color=auto"
  alias fgrep="${aliases[fgrep]:-fgrep} --color=auto"
fi

# File download.
if (( $+commands[curl] )); then
	alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
	alias get='wget --continue --progress=bar --timestamping'
fi

# Top
if [[ "$OSTYPE" == (darwin*|*bsd*) ]]; then
  if isCallable 'htop'; then
		alias top='nocorrect sudo htop'			# Run 'sudo' because there are no PROC files in macOS
    alias topc="${aliases[top]:-sudo htop} --sort-key=PERCENT_CPU"	# Sort with CPU usage
    alias topm="${aliases[top]:-sudo htop} --sort-key=PERCENT_MEM"	# Sort with MEM usage
  else
    alias topc='top -o cpu'
    alias topm='top -o vsize'
  fi
else
  alias topc='top -o %CPU'
  alias topm='top -o %MEM'
fi

# Copy N Paste
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias pbc='pbcopy'
  alias pbp='pbpaste'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
else
  alias o='xdg-open'
  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi
