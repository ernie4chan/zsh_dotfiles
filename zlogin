# vim: noet sw=2 sts=2 ts=2 ft=zsh

# Execute code that does not affect the current session in the background.
{
	local dir file
	local function_glob='(^*test*/)#*.zsh{,-theme}(.NLk+1)'
	setopt LOCAL_OPTIONS EXTENDED_GLOB
	autoload -Uz zrecompile

# zcompile the completion cache; siginificant speedup.
	zrecompile -pq $HOME/.zcompdump
	[[ -f $HOME/.zcompdump.zwc.old ]] && command rm -f $HOME/.zcompdump.zwc.old

# zcompile .zshrc.
	zrecompile -pq $HOME/.zshrc
	[[ -f $HOME/.zshrc.zwc.old ]] && command rm -f $HOME/.zshrc.zwc.old

# zcompile enabled module autoloaded functions.
	for dir in $HOME/.zsh/modules/${^zmodules}/functions(/FN); do
	  zrecompile -pq ${dir}.zwc $dir/^(_*|prompt_*_setup|*.*)(-.N)
	done

# zcompile enabled module scripts.
	for file in $HOME/.zsh/modules/${^zmodules}/${~function_glob}; do
	  zrecompile -pq $file
	done
} &!
