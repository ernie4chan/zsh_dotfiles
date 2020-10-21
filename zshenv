# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Shell environment variables, which are executed before zshrc.
#

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

# Preferred editor, pager and browser. macOS does not set $BROWSER by default.
export EDITOR='vim'
export PAGER='less'
if [[ "$OSTYPE" == linux* ]]; then
	export VISUAL='gvim'
elif [[ "$OSTYPE" == darwin* ]]; then
	export VISUAL='mvim'
	export BROWSER='open'
fi
