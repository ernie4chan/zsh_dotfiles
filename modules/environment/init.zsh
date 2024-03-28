# ---------------------------------------------------------
# vim: ts=4 sts=2 ft=zsh
#
# File: ./environment/init.zsh
#
# Defining Zsh environment variables.
#
# Author: Ernie Lin
# Update: 2022-06-10
# ---------------------------------------------------------

# {{{ --- Pager, Editors & Browsers. ---

# Shell language.
if [[ -z "$LANG" ]]; then
	export LC_ALL='en_US.UTF-8'
	export LANG='en_US.UTF-8'
fi

# Less Preferences.
export LESSHISTFILE="$HOME/.less_history"
export LESSEDIT='vim ?lm+%lm. %f'
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
export LESS='-g -i -M -R -S -w -X -z-4'

# Termcap.
if zstyle -t ':e4czmod:environment:termcap' color; then
	export LESS_TERMCAP_mb=$'\E[01;31m'		# Begins blinking.
	export LESS_TERMCAP_md=$'\E[01;31m'		# Begins bold.
	export LESS_TERMCAP_me=$'\E[0m'			# Ends mode.
	export LESS_TERMCAP_se=$'\E[0m'			# Ends standout-mode.
	export LESS_TERMCAP_so=$'\E[00;47;30m'	# Begins standout-mode.
	export LESS_TERMCAP_ue=$'\E[0m'			# Ends underline.
	export LESS_TERMCAP_us=$'\E[01;32m'		# Begins underline.
fi

# Preferred apps.
export EDITOR='vim'
export PAGER='less'

if is-linux; then
	export VISUAL='gvim'
elif is-darwin; then
	export VISUAL='mvim'
fi

if (( $+commands[xdg-open] )); then
	export BROWSER='xdg-open'
elif (( $+commands[open] )); then
	export BROWSER='open'
fi

# }}}

# {{{ --- Zsh History. ---

# Preferences.
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000	# Maximum history events in mem.
export SAVEHIST=50000	# Maximum history file size.

# History options.
setopt BANG_HIST			# Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY		# History file format as ':start:elapsed;command'.
setopt HIST_BEEP			# Beep when accessing non-existent history.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS	# Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS	# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS		# Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE	# Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS	# Do not write a duplicate event to the history file.
setopt HIST_VERIFY			# Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY	# Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY		# Share history between all sessions.

# }}}

# {{{ --- Shell Behavior. ---

# Behaviour.
setopt COMBINING_CHARS	# Combine zero-length punctuation characters (accents) with the base character.
setopt INTERACTIVE_COMMENTS	# Enable comments in interactive shell.
setopt RC_QUOTES		# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt BEEP			# Beep on error.
unsetopt MAIL_WARNING	# Don't print a warning message if a mail file has been accessed.

# Jobs.
setopt AUTO_RESUME		# Attempt to resume existing job before creating a new process.
setopt LONG_LIST_JOBS	# List jobs in the long format by default.
setopt NOTIFY			# Report status of background jobs immediately.
unsetopt BG_NICE		# Don't run all background jobs at a lower priority.
unsetopt CHECK_JOBS		# Don't report on jobs when shell exit.
unsetopt HUP			# Don't kill jobs on shell exit.

# Directory.
setopt AUTO_CD			# Auto changes to a directory without typing cd.
setopt AUTO_PUSHD		# Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS	# Do not store duplicates in the stack.
setopt PUSHD_SILENT		# Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME	# Push to home directory when no argument is given.
unsetopt CDABLE_VARS	# Do not Change directory to a path stored in a variable.

# I/O.
setopt EXTENDED_GLOB	# Use extended globbing syntax and needed with 'compinit'.
setopt MULTIOS			# Write to multiple descriptors.
unsetopt CLOBBER		# Do not overwrite existing files with > and >>, use >! and >>! to bypass.

# Completion (also check 'Completions' module).
setopt ALWAYS_TO_END	# Move cursor to the end of a completed word.
setopt AUTO_LIST		# Automatically list choices on ambiguous completion.
setopt AUTO_MENU		# Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH	# If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD	# Complete from both ends of a word.
setopt PATH_DIRS		# Perform path search even on command names with slashes.
unsetopt FLOW_CONTROL	# Disable start/stop characters in shell editor.
unsetopt MENU_COMPLETE	# Do not autoselect the first completion entry.

# }}}
