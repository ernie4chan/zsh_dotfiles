# vim: ft=zsh

# Shell environment variables, which are executed before zshrc.

# Ensure arrays do not contain duplicates.
#  '-U' converts upper to lower case.
typeset -gU path cdpath fpath infopath manpath

# List directories that searches for shell functions.
path=(
	/usr/local/{,s}bin
	$path
)

cdpath=(
	$HOME
	$cdpath
)

fpath=(
	$fpath
)

infopath=(
	/usr/share/info
	/usr/local/share/info
	$infopath
)

manpath=(
	/usr/share/man
	/usr/local/share/man
  $manpath
)

# Language.
if [[ -z "$LANG" ]]; then
	export LC_ALL='en_US.UTF-8'
	export LANG='en_US.UTF-8'
fi

# Preferred editor for local and remote sessions.
export PAGER='less'
export EDITOR='vim'

# Less preferences.
export LESSHISTFILE=$HOME/.less_history
export LESS='-g -i -M -R -S -w -X -z-4'
export LESSEDIT='vim ?lm+%lm. %f'

# History preferences.
export HISTFILE=$HOME/.zhistory
export HISTSIZE=10000		# Maximum internal history events
export SAVEHIST=10000		# Maximum history file size

# Golang programming language.
if [[ -s "$(which go)" ]]; then
	path=(
		$GOPATH/bin
		$GOROOT/bin
		$path
	)
	export GOPATH=$HOME/Projects/ws-Go
	export GOROOT=/usr/local/opt/go/libexec
fi

# All macOS realted.
if [[ "$OSTYPE" == darwin* ]]; then
	export VISUAL='mvim'
	export BROWSER='open'
fi

# Load and initialize the completion system ignoring insecure directories
#  with a cache time of 20 hours, so it should almost always regenerate 
#  the first time a shell is opened each day.
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
fi
unset _comp_path

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
