# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Shell environment variables, which are executed before zshrc.

# Ensure arrays do not contain duplicates.
# '-U' converts upper to lower case.
typeset -U cdpath fpath infopath manpath path

# List directories that searches for shell functions.
path=(
  /usr/local/{,s}bin
	$HOME/.Perl5/bin
  $HOME/.bin
  $GOPATH/bin
  $GOROOT/bin
  $path
)
export PATH

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

# Language.
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# Browser.
if [[ $OSTYPE == darwin* ]]; then
	export BROWSER='open'
fi

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
	export PAGER='less'
	export EDITOR='vim'
else
	export VISUAL='mvim'
	export PAGER='less'
	export EDITOR='vim'
fi

# Golang programming language.
export GOPATH=$HOME/Projects/Go-workspace
export GOROOT=/usr/local/opt/go/libexec

# Perl CPAN configuration.
PERL5LIB="$HOME/.Perl5/lib/perl5"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.Perl5"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.Perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.Perl5"; export PERL_MM_OPT;

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
