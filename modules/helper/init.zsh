# ---------------------------------------------------------
# vim: ft=zsh
#
# File: ./helper/init.zsh
#
# Defining helper functions.
#
# Author: Ernie Lin
# Update: 2025/03/26
# ---------------------------------------------------------

# Checks if a file can be autoloaded by trying to load it in a subshell.
is-autoloadable() {
		( unfunction $1; autoload -U +X $1 ) &>/dev/null
}

# Checks if a name is a command, function, or alias.
is-callable() {
		(( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Checks if a boolean variable is "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
is-true() {
		[[ "${1:l}" =~ ^(1|y(es)?|t(rue)?|o(n)?)$ ]]
}

# Prints the first non-empty string in the argument array.
coalesce() {
		for arg in "$@"; do [[ -n "$arg" ]] && print "$arg" && return 0; done
		return 1
}

# Checks running OS type.
is-linux()   { [[ "$OSTYPE" == linux* ]] }
is-termux()  { [[ "$OSTYPE" == linux-android ]] }
is-bsd()     { [[ "$OSTYPE" == *bsd* ]] }
is-cygwin()  { [[ "$OSTYPE" == cygwin* ]] }
is-darwin()  { [[ "$OSTYPE" == darwin* ]] }