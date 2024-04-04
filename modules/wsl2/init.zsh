# ---------------------------------------------------------
# vim: ts=2 ft=zsh
#
# File: ./macos/init.zsh
#
# Define Windows or Windows Subsystem aliases and functions.
#
# Author: Ernie Lin
# Update: 2024-04-04
# ---------------------------------------------------------

# For WSL2.
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1