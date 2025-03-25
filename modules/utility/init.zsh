# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./utility/init.zsh
#
# Defines general aliases and functions.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Correct commands.
if zstyle -T ':e4czmod:module:aliases' correct; then
	setopt CORRECT
fi

# Load 'run-help' function.
autoload -Uz run-help-{ip,openssl,sudo}

# {{{ --- Aliases. ---

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

# Disable globbing.
alias ftp='noglob ftp'
alias sftp='noglob sftp'

# Lists the ten most used commands.
alias key-stats="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Surfing directory on steroids.
alias 0='dirs -v'				# List last used directories.

for index in {1..9}; do
	alias "${index}"="cd +${index}"
	alias ".${index}"="cd $(printf "%0.s../" $(seq 1 ${index}))"
done

unset index

alias diffu="diff --unified"
alias fixtty='stty sane'		# Restore terminal settings when screwed up.
alias ga='alias | grep -i'
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias myip='echo "Current IP is $(curl -s ifconfig.co)"' # Published IP add.
alias po='popd'
alias ptt='ssh bbsu@ptt.cc'		# Open up BBS: PTT.
alias pu='pushd'
alias py3='python3'				# Redifining python3 shell.

# Safe ops. Ask the user before doing anything destructive.
alias cpi="${aliases[cp]:-cp} -i"
alias lni="${aliases[ln]:-ln} -i"
alias mvi="${aliases[mv]:-mv} -i"
alias rmi="${aliases[rm]:-rm} -i"
if zstyle -T ':e4czmod:module:aliases' safe-ops; then
	alias cp="${aliases[cp]:-cp} -i"
	alias ln="${aliases[ln]:-ln} -i"
	alias mv="${aliases[mv]:-mv} -i"
	alias rm="${aliases[rm]:-rm} -i"
fi

# 3rd-Party Apps:
if is-callable 'abcde'; then alias abcde="abcde -c $HOME/.config/abcde/abcde.cfg"; fi
if is-callable 'irssi'; then alias irssi="irssi --home=$HOME/.config/irssi"; fi
if is-callable 'lynx'; then alias lynx="lynx -cfg=$HOME/.config/lynx/lynx.cfg"; fi
if is-callable 'tree'; then alias shu='tree -N -L 2'; fi
if is-callable 'wget'; then alias wget='wget --hsts-file=~/.wget_history'; fi

# }}}

# {{{ --- Re-defining 'ls'. ---

if [[ ${(@M)${(f)"$(ls --version 2>&1)"}:#*GNU *} ]]; then
	# GNU Core Utilities.
	if zstyle -T ':e4czmod:module:aliases:ls' dirs-first; then
		alias ls="${aliases[ls]:-ls} --group-directories-first"
	fi

	if zstyle -t ':e4czmod:module:aliases:ls' color; then
		# Define colors for GNU ls if they're not already defined.
		if (( ! $+LS_COLORS )); then
			# Try dircolors when available
			if is-callable 'dircolors'; then
				eval "$(dircolors --sh $HOME/.dir_colors(.N))"
			else
				export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
			fi
		fi

		alias ls="${aliases[ls]:-ls} --color=auto"
	else
		alias ls="${aliases[ls]:-ls} -F"
	fi
else
	# BSD Core Utilities
	if zstyle -t ':e4czmod:module:aliases:ls' color; then
		# Define colors for BSD ls if they're not already defined
		if (( ! $+LSCOLORS )); then
			export LSCOLORS='exfxcxdxbxGxDxabagacad'
		fi

		alias ls="${aliases[ls]:-ls} -G"
	else
		alias ls="${aliases[ls]:-ls} -F"
	fi
fi

alias l='ls -F1'	# Lists in one column, hidden files.
alias ll='ls -lh'	# Lists human readable sizes.
alias la='ls -lhA'	# Lists human readable sizes, hidden files.
alias lr='ls -lhR'	# Lists human readable sizes, recursively.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lk='ll -Sr'	# Lists sorted by size, largest last.
alias lt='ll -tr'	# Lists sorted by date, most recent last.
alias lc='ll -trc'	# Lists sorted by date, most recent last, shows change time.
alias lu='ll -tru'	# Lists sorted by date, most recent last, shows access time.

# Lists sorted by extension (GNU only).
if [[ ${(@M)${(f)"$(ls --version 2>&1)"}:#*GNU *} ]]; then
	alias lx='ll -XB'
fi

# }}}

# {{{ --- Coloring Grep. ---

if zstyle -t ':e4czmod:module:aliases:grep' color; then
	if [[ ${(@M)${(f)"$(ls --version 2>&1)"}:#*GNU *} ]]; then
		export GREP_COLORS=${GREP_COLORS:-"mt=37;45"}	# GNU.
	else
		export GREP_COLOR=${GREP_COLOR:-'37;45'}		# BSD.
	fi

	alias grep="${aliases[grep]:-grep} --color=auto"
fi

# }}}1

# {{{ --- Copy & Paste. ---

if is-darwin; then
	alias oo='open'
elif is-cygwin; then
	alias oo='cygstart'
	alias pbcopy='tee > /dev/clipboard'
	alias pbpaste='cat /dev/clipboard'
elif is-termux; then
	alias oo='termux-open'
	alias pbcopy='termux-clipboard-set'
	alias pbpaste='termux-clipboard-get'
else
	if (( $+commands[xdg-open] )); then
		alias oo='xdg-open'
	fi

	if (( $+commands[xclip] )); then
		alias pbcopy='xclip -selection clipboard -in'
		alias pbpaste='xclip -selection clipboard -out'
	elif (( $+commands[xsel] )); then
		alias pbcopy='xsel --clipboard --input'
		alias pbpaste='xsel --clipboard --output'
	fi
fi

# }}}
