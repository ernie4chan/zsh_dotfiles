#!/usr/local/bin/zsh

# Failsafe test purposes and debugging.
#zsh -x 2> $HOME/zsh-error.log

# Show an illustrative output on Zsh startup loading. 
#zmodload zsh/zprof

# Load Powerline-status theme.
#POWERLINE_SCRIPT=$HOME/.local/lib/powerline/bindings/zsh/powerline.zsh 
#[[ -f $POWERLINE_SCRIPT ]] && source $POWERLINE_SCRIPT

# Load Powerlevel9k theme (replacing Powerline-status).
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)

# Loading modules (order matters).
zmodules=(
	powerlevel9k
  environment
  gnu-utililty
  helper
  spectrum
  aliases
	completion
  tmux
	iterm2
)

# Let's run that module lists.
for zmodule in $zmodules; do
  if [[ -e $HOME/.zsh/zmodules/$zmodule.zsh ]]; then
    source $HOME/.zsh/zmodules/$zmodule.zsh
  elif [[ -e $HOME/.zsh/zmodules/$zmodule.plugin.zsh ]]; then
    source $HOME/.zsh/zmodules/$zmodule.plugin.zsh
  fi
done
unset zmodule{,s}

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':zmodule:*:*' case-sensitive 'yes'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':zmodule:*:*' color 'yes'

# Completions: set the entries to ignore in static */etc/hosts* for host completion.
zstyle ':zmodule:completion:*:hosts' etc-host-ignores '0.0.0.0' '127.0.0.1'

# GNU core utility: set the command prefix on non-GNU systems.
zstyle ':zmodule:gnu-utility' prefix 'g'
