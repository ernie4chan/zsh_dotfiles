# vim: ft=zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Failsafe test purposes and debugging.
#zsh -x 2> ${HOME}/zsh-error.log

# Set input mode before loading the module.
bindkey -v

# Set base directory.
ZDOTDIR="$HOME/.zsh"

# Load 'zstyle'.
if [[ -s "$ZDOTDIR/zstyle" ]]; then
	source "$ZDOTDIR/zstyle"
fi

# Load all the modules you want!
zstyle ':zmodule:load' pmodule \
	'environment' \
	'gnu_utility' \
	'aliases' \
	'fzf' \
	'tmux' \
	'autosuggestions' \
	'completions' \
	'syn_highlight' \
	'hist_sub_search'

# Load 'pmodload'.
if [[ -s "$ZDOTDIR/pmodload.zsh" ]]; then
	source "$ZDOTDIR/pmodload.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
ZP10K="$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f "$ZP10K" ]] || source "$ZP10K"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Unset base directory.
unset ZDOTDIR
unset ZP10K

if [[ -s "$(which thefuck)" ]]; then
	eval $(thefuck --alias)
fi
