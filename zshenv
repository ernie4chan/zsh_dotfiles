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

# Ensure arrays do not contain duplicates.
typeset -xUT CDPATH cdpath
typeset -xUT FPATH fpath
typeset -xUT INFOPATH infopath
typeset -xUT LD_LIBRARY_PATH ld_library_path
typeset -xUT MANPATH manpath
typeset -xUT PATH path

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

ld_library_path=(
	/usr/local/cuda/lib64
	$ld_library_path
)

manpath=(
	/usr/{local/,}share/man
	$manpath
)

path=(
	/usr/local/cuda/bin
	/usr/local/{,s}bin
	$HOME/.local/{,s}bin
	$path
)
