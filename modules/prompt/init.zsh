# ---------------------------------------------------------
# vim: ft=zsh
#
# File: ./prompt/init.zsh
#
# Loads prompt themes.
#
# Author: Ernie Lin
# Update: 2025-03-30
# ---------------------------------------------------------

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':e4czmod:module:prompt' theme 'prompt_argv'

[[ "$TERM" == (dumb|linux|*bsd*) ]] || (( $#prompt_argv == 0 )) \
		&& prompt off || prompt "$prompt_argv[@]"

unset prompt_argv