# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: ./macos/init.zsh
#
# Define macOS aliases and functions.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Return if requirements are not found.
[[ is-darwin ]] || return 1

# External Devices.
alias inject='diskutil mount'	# Mount devices.
alias eject='diskutil umount'	# Unmount devices.

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias puf='pushd "$(pfd)"'
