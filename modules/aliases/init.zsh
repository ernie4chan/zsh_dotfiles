# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Defines general aliases and functions.
#

# Load dependencies.
pmodload 'helper'

# Correct commands.
if zstyle -T ':zmodule:utility' correct; then
	unsetopt CORRECT_ALL
fi

# {{{1 --- Aliases ---

# Disable correction.
alias mv='nocorrect mv'
alias rm='nocorrect rm'

# Directory aliases.
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias po='popd'
alias pu='pushd'
alias 0='dirs -v'					# List last used directories
for index ({1..9}) alias "${index}"="cd +${index}"; unset index
for index ({1..9}) alias ".${index}"="cd $(printf "%0.s../" $(seq 1 ${index}))"; unset index

# Customize some aliases.
alias tp='trash-put'
alias df='df -kh'					# More human readable
alias du='du -kh'					# More human readable
alias ftty='stty sane'		# Restore terminal settings when screwed up
alias myip='echo "Current IP is $(curl -s ifconfig.co)"' # Published IP add.
alias ptt='ssh bbsu@ptt.cc'		# Open up BBS: PTT
alias py3='python3'				# Redifining python3 shell

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# 3rd party app aliases.
if is-callable 'irssi'; then alias irssi="TERM=screen irssi \
	--home=~/.local/share/irssi"; fi
if is-callable 'lynx'; then alias lynx="lynx -cfg=$HOME/.config/lynx/lynxrc"; fi
if is-callable 'mc'; then alias mc="SHELL=/bin/bash \
	LANG=en_US.UTF-8 source /usr/lib/mc/mc-wrapper.sh -x"; fi
if is-callable 'mutt'; then alias mutt="mutt -F ~/.local/share/mutt/muttrc"; fi
# Load tmux with specific config file
if is-callable 'tmux'; then alias tmux="tmux -u -f $HOME/.zsh/tmuxrc"; fi
# Fix Tree with Unicode
if is-callable 'tree'; then alias shu='tree -N'; fi

# macOS aliases.
if is-darwin; then
	alias ofd='open .'								# Open current directory in Finder
	alias sfd='SyncFinder'						# Sync current directory in Terminal
	alias inject="diskutil mount $@"	# Mount external devices
	alias eject="diskutil unmount $@"	# Unmount external devices
	alias ql="qlmanage -p $@ 2>/dev/null"		# View images
	# Search files using macOS Spotlight's metadata:
	#  w: the comparison is word-based and detects transitions from lower-case to upper-case.
	#  c: the comparison is case insensitive.
	locate () { mdfind "kMDItemDisplayName == '$@'wc"; }

	# Change directory to the current Finder folder.
	SyncFinder () {
		target=`osascript -e 'tell application "Finder" to if \
		(count of Finder windows) > 0 then get POSIX path of \
		(target of front Finder window as text)'`;
		if [ "$target" != "" ]; then cd "$target"; pwd; \
		else echo 'No Finder window found' >&2; fi;
		}

	# Recursively delete Apple files.
	clearmacOS () {
		list=( .DS_Store ._.Trashes );
		for i in $list; do find . -type f -name $i -ls -delete 2>/dev/null; done;
		}
fi

# }}}1

# {{{1 --- Advanced Aliases ---

# {{{2 - modified ls -

if is-callable 'dircolors'; then
# GNU Core Utilities
	if zstyle -T ':zmodule:utility:ls' dirs-first; then
		alias ls="${aliases[ls]:-ls} --group-directories-first"
	fi

	if zstyle -t ':zmodule:utility:ls' color; then
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
	# BSD Core Utilities
	if zstyle -t ':zmodule:utility:ls' color; then
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

# }}}2

# {{{2 - ...more of ls -

alias ll='ls -Flh'			# List files as a long list, show size, type, human-readable
alias la='ls -FlhA'			# List almost all files as a long list show size, type, human-readable
alias lr='ls -FthR'			# List files recursively sorted by date, show type, human-readable
alias lt='ls -Flht'			# List files as a long list sorted by date, show type, human-readable
alias ld='ls -ld .*'		# List dot files as a long list
alias lo='ls -1FSsh'		# List files showing only size and name sorted by size
alias lz='ls -1Fcart'		# List all files sorted in reverse of create/modification time (oldest first)

# }}}2

# {{{2 - Copy N Paste -

if is-darwin; then
	alias o='open'
elif is-cygwin; then
	alias o='cygstart'
	alias pbcopy='tee > /dev/clipboard'
	alias pbpaste='cat /dev/clipboard'
elif is-termux; then
	alias o='termux-open'
	alias pbcopy='termux-clipboard-set'
	alias pbpaste='termux-clipboard-get'
else
	alias o='xdg-open'

	if (( $+commands[xclip] )); then
		alias pbcopy='xclip -in -selection clipboard'
		alias pbpaste='xclip -out -selection clipboard'
	elif (( $+commands[xsel] )); then
		alias pbcopy='xsel --clipboard --input'
		alias pbpaste='xsel --clipboard --output'
	fi
fi

# }}}2

# {{{2 - grep -

if zstyle -T ':zmodule:utility:grep' color; then
	export GREP_COLOR='37;45'								# BSD
	export GREP_COLORS="mt=$GREP_COLOR"			# GNU

	alias grep="${aliases[grep]:-grep} --color=auto"
	alias egrep="${aliases[egrep]:-egrep} --color=auto"
	alias fgrep="${aliases[fgrep]:-fgrep} --color=auto"
fi

# }}}2

# {{{2 - File download -

if (( $+commands[curl] )); then
	alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
	alias get='wget --continue --progress=bar --timestamping'
fi

# }}}2

# }}}1
