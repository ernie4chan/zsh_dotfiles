# vim: ts=4 ft=sh
#
# Define macOs aliases and functions.
#

# Return if requirements are not found.
if ! is-darwin; then
	return 1
fi

# External Devices.
alias inject='diskutil mount'		# Mount devices.
alias eject='diskutil umount'		# Unmount devices.

# Open current directory in Finder.
alias oof='open .'

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias puf='pushd "$(pfd)"'
