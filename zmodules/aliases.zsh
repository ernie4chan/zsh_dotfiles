#!/usr/bin/env zsh

#
# Defines general aliases and functions.
#   Must source 'helper' and 'spectrum' modules first.
#

# Correct commands.
setopt CORRECT

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias py3='nocorrect bpython'			    # Redifining python3 shell
alias rm='nocorrect rm'

# Directory aliases.
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Customize some aliases.
alias d='dirs -v'							# List last used directories
alias df='df -kh'							# More human readable
alias du='du -kh'							# More human readable
alias ftty='stty sane'				# Restore terminal settings when screwed up
alias htop='nocorrect sudo htop'			# Run 'sudo' because there are no PROC files in macOS
alias mc=". ~/.local/bin/mc-wrapper-zsh.sh"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias po='popd'
alias pu='pushd'
alias ptt='nocorrect ssh bbsu@ptt.cc'	# Open up BBS: PTT
alias tree='tree -N'		      # Fix tree
alias tmux="nocorrect tmux -f $HOME/.tmuxrc"
alias itun=". ~/.local/bin/itunes.sh"

# Super ugly hack aliases
alias update-zsh="find ~/.zsh -type d -name .git | xargs -n 1 dirname | while read line; do echo $line && cd $line && git pull; cd -; done"

# GNU Core Utilities.
# - ls -
if is-callable 'dircolors'; then
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

# Define colors for the completion system if they're not already defined.
if [[ -z $LS_COLORS ]]; then
	export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
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
export GREP_COLORS="mt=$GREP_COLOR"	# GNU
alias grep="${aliases[grep]:-grep} --color=auto"

# File download.
if (( $+commands[curl] )); then
	alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
	alias get='wget --continue --progress=bar --timestamping'
fi
