# ---------------------------------------------------------
# vim: ts=4 ft=zsh
#
# File: .zshenv
#
# Shell environment variables, executed before zshrc.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

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
