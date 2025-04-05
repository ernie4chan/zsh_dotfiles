# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: ./zshenv
#
# Shell environment variables, executed before ".zshrc".
#
# Author: Ernie Lin
# Update: 2025-04-01
# ---------------------------------------------------------

# Ensure the data are:
# (1) -x, export to parameter; (2) -U, keey array values unique; (3) -T, tie scalar to array.
typeset -xUT CDPATH cdpath=(
	$HOME/Projects
	$cdpath
)

typeset -xUT FPATH fpath=(
	$fpath
)

typeset -xUT INFOPATH infopath=(
	/usr/{,local/}share/info
	$infopath
)

typeset -xUT MANPATH manpath=(
	/usr/{,local/}share/man
	$manpath
)

typeset -xUT PATH path=(
	/usr/local/{,s}bin
	$HOME/.local/{,s}bin
	$path
)