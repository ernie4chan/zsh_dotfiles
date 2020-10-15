# vim: ts=2 sw=2 sts=2 noet ft=zsh

#
# Defines helper functions.
#

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

# is true on MacOS Darwin
function is-darwin {
	[[ "$OSTYPE" == darwin* ]]
}

# is true on Linux's
function is-linux {
	[[ "$OSTYPE" == linux* ]]
}

# is true on BSD's
function is-bsd {
	[[ "$OSTYPE" == *bsd* ]]
}

# is true on Cygwin (Windows)
function is-cygwin {
	[[ "$OSTYPE" == cygwin* ]]
}

# is true on termux (Android)
function is-termux {
	[[ "$OSTYPE" == linux-android ]]
}
