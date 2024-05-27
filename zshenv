# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: .zshenv
#
# Shell environment variables, executed before ".zshrc".
#
# Author: Ernie Lin
# Update: 2022-06-10
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
	/usr/{local/,}share/info
	$infopath
)

typeset -xUT LD_LIBRARY_PATH ld_library_path=(
	/usr/local/cuda/lib64
	$ld_library_path
)

typeset -xUT MANPATH manpath=(
	/usr/{local/,}share/man
	$manpath
)

typeset -xUT PATH path=(
	/usr/local/cuda/bin
	/usr/local/{,s}bin
	$HOME/.local/{,s}bin
	$path
)
