#
# Loads prompt themes.
#

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':zmodule:prompt' theme 'prompt_argv'
if [[ "$TERM" == (dumb|linux|*bsd*) ]] || (( $#prompt_argv < 1 )); then
	prompt 'off'
else
	prompt "$prompt_argv[@]"
fi
unset prompt_argv

if zstyle -T ':zmodule:prompt:p10k' running; then
	[[ -f "$ZDOTDIR/p10k.zsh" ]] && source "$ZDOTDIR/p10k.zsh"
fi
