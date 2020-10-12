# vim: noet sw=2 sts=2 ts=2 ft=zsh

#
# Shell environment variables, which are executed before zshrc.
#

# Ensure arrays do not contain duplicates.
#  '-U' converts upper to lower case.
typeset -gU path cdpath fpath infopath manpath

# List directories that searches for shell functions.
path=(
	/usr/local/{,s}bin
	$path)

cdpath=(
	$HOME
	$cdpath)

fpath=(
	$fpath)

infopath=(
	/usr/share/info
	/usr/local/share/info
	$infopath)

manpath=(
	/usr/share/man
	/usr/local/share/man
  $manpath)

# Language.
if [[ -z "$LANG" ]]; then
	export LC_ALL='en_US.UTF-8'
	export LANG='en_US.UTF-8'
fi

# Preferred editor for local and remote sessions.
export PAGER='less'
export EDITOR='vim'

# Less preferences.
export LESSHISTFILE="$HOME"/.less_history
export LESSEDIT='vim ?lm+%lm. %f'
export LESS='-MRigSXw -z-4 --mouse --wheel-lines=3'

# History preferences.
export HISTFILE="$HOME"/.zhistory
export HISTSIZE=10000		# Maximum internal history events
export SAVEHIST=10000		# Maximum history file size

# Golang programming.
if [[ -s $(which go) ]]; then
	path=(
		$GOPATH/bin
		$GOROOT/bin
		$path)
	export GOPATH="$HOME"/Projects/ws-Go
	export GOROOT=/usr/local/opt/go/libexec
fi

# All macOS related.
if [[ "$OSTYPE" == darwin* ]]; then
	export VISUAL='mvim'
	export BROWSER='open'
fi
