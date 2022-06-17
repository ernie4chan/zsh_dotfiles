# ---------------------------------------------------------
# vim: ts=4 ts=2 ft=zsh
#
# File: ./prompt/init.zsh
#
# Loads prompt themes.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':e4czmod:module:prompt' theme 'prompt_argv'

if [[ "$TERM" == (dumb|linux|*bsd*) ]] || (( $#prompt_argv < 1 )); then
	prompt 'off'
else
	prompt "$prompt_argv[@]"
fi

unset prompt_argv
