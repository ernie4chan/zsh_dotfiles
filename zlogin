# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: .zlogin
#
# Executes commands at login post-'.zshrc'.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# For WSL2
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1
