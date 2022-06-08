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
elif [[ "$prompt_argv[1]" == 'powerlevel10k' ]] ; then
	# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
	# Initialization code that may require console input (password prompts, [y/n]
	# confirmations, etc.) must go above this block; everything else may go below.
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
		source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
	prompt "$prompt_argv[@]"
else
	prompt "$prompt_argv[@]"
fi
unset prompt_argv
