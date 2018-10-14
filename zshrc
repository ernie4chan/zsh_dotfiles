#!/usr/bin/env zsh

# Failsafe test purposes and debugging.
#zsh -x 2> $HOME/zsh-error.log

# Ensure arrays do not contain duplicates.
#   '-U' converts upper to lower case.
typeset -U cdpath fpath infopath manpath path

# List directories that searches for shell functions.
cdpath=(
  $HOME
  $cdpath
)

fpath=(
  $fpath
)

infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

path=(
  $HOME/.local/{,s}bin
  /usr/local/{,s}bin
  $GOPATH/bin
  $GOROOT/bin
  $path
)

# Github API token for Homebrew.
export HOMEBREW_GITHUB_API_TOKEN=c2f5a5d8a2437becdb7b8f8a902101b760d777c1

# Prevent Homebrew from gathering analytics.
export HOMEBREW_NO_ANALYTICS=1

# Golang programming language.
export GOPATH=$HOME/Projects/Go-workspace
export GOROOT=$(brew --prefix golang)/libexec

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
	export PAGER='less'
	export EDITOR='vim'
else
	export VISUAL='mvim'
	export PAGER='less'
	export EDITOR='vim'
fi

# Loading modules (order matters).
zmodules=(
  environment
  gnucoreutils
  helper
  spectrum
  aliases
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

# Invoke completion system for use.
autoload -Uz compinit
compinit
