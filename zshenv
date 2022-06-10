# vim: ts=4 ft=zsh
#
# Shell environment variables, executed before zshrc.
#

# Ensure arrays do not contain duplicates.
typeset -U cdpath fpath infopath mailpath manpath path

# List directories that searches for shell functions.
cdpath=(
	$HOME/Projects
	$cdpath
)

fpath=(
	$fpath
)

infopath=(
	/usr/{local/,}share/info
	$infopath
)

manpath=(
	/usr/{local/,}share/man
	$manpath
)

path=(
	~/Library/Python/3.10/bin
	/usr/local/{,s}bin
	$path
)

# Shell language.
if [[ -z "$LANG" ]]; then
	export LC_ALL='en_US.UTF-8'
	export LANG='en_US.UTF-8'
fi
