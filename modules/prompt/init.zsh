# vim: ts=4 ft=zsh
#
# Loads prompt themes.
#

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
