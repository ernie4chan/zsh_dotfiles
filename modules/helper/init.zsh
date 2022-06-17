# ---------------------------------------------------------
# vim: ts=4 ts=2 ft=zsh
#
# File: ./helper/init.zsh
#
# Defining helper functions.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Checks if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
	( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

# Checks if a name is a command, function, or alias.
function is-callable {
	(( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
	[[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
	for arg in $argv; do
		print "$arg"
		return 0
	done
	return 1
}

# Checks if running on macOS Darwin.
function is-darwin {
	[[ "$OSTYPE" == darwin* ]]
}

# Checks if running on Linux.
function is-linux {
	[[ "$OSTYPE" == linux* ]]
}

# Checks if running on BSD.
function is-bsd {
	[[ "$OSTYPE" == *bsd* ]]
}

# Checks if running on Cygwin (Windows).
function is-cygwin {
	[[ "$OSTYPE" == cygwin* ]]
}

# Checks if running on termux (Android).
function is-termux {
	[[ "$OSTYPE" == linux-android ]]
}
