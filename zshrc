# vim: ft=zsh

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
	'gpg' \
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
