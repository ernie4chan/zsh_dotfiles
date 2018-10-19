#!/usr/local/bin/zsh

# Failsafe test purposes and debugging.
#zsh -x 2> $HOME/zsh-error.log

# Show an illustrative output on Zsh startup loading. 
#zmodload zsh/zprof

# Loading modules (order matters).
zmodules=(
  environment
  gnucoreutils
  helper
  spectrum
  aliases
	completion
  prompt_themes
  tmux
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

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
