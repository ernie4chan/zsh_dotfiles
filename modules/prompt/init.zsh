# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/prompt/init.zsh
# Title: Prompt themes.
# Maintainer: Ernie Lin
# Update:
#	20250330
#	20260509
# ---------------------------------------------------------

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':e4czmod:module:prompt' theme 'prompt_argv'

[[ $TERM == (dumb|linux|*bsd*) ]] || (( $#prompt_argv <1 )) \
    && prompt off || prompt "$prompt_argv[@]"

unset prompt_argv
