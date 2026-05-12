# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/zshenv
# Title: Shell environment variables, executed before ".zshrc".
# Maintainer: Ernie Lin
# Update:
#	20250401
#	20260501
# ---------------------------------------------------------

# Shell language.
export LANG=${LANG:-en_US.UTF-8}
export LC_ALL=${LC_ALL:-$LANG}

# Ensure the data are:
# (1) -x, export to parameter;
# (2) -U, keey array values unique;
# (3) -T, tie scalar to array.
typeset -xUT CDPATH cdpath=(
	$cdpath
)

typeset -xUT FPATH fpath=(
	$fpath
)

typeset -xUT PATH path=(
	$HOME/.local/bin
	/{usr/{local/,},}{,s}bin
	/{,s}bin
	$path
)
