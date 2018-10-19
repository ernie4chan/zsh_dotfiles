#!/usr/local/bin/zsh

# Shell environment variables, which are executed before zshrc.

# Ensure arrays do not contain duplicates.
# '-U' converts upper to lower case.
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

# Language.
if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

# Browser.
if [[ "$OSTYPE" == darwin* ]]; then
	export BROWSER='open'
fi

# Less preferences
export LESSCHARSET="UTF-8"
export LESSHISTFILE=$HOME/.less_history
export LESS='-g -i -M -R -S -w -X -z-4'
export LESSEDIT='vim ?km+%lm. %f'

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
	export PAGER='less'
	export EDITOR='vim'
else
	export VISUAL='mvim'
	export PAGER='less'
	export EDITOR='vim'
fi

# History preferences
HISTFILE=$HOME/.zhistory    # The path to the history file.

# Github API token for Homebrew.
export HOMEBREW_GITHUB_API_TOKEN=c2f5a5d8a2437becdb7b8f8a902101b760d777c1

# Prevent Homebrew from gathering analytics.
export HOMEBREW_NO_ANALYTICS=1

# Golang programming language.
export GOPATH=$HOME/Projects/Go-workspace
export GOROOT=$(brew --prefix golang)/libexec
