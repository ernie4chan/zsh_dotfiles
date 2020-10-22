# vim: ts=4 sw=4 sts=4 noet ft=zsh

#
# Overall zsh environment option and not populate conditions in 'zhsenv'.
#

# This logic comes from an old version of zim. Essentially, bracketed-paste was
#  added as a requirement of url-quote-magic in 5.1, but in 5.1.1 bracketed
#  paste had a regression. Additionally, 5.2 added bracketed-paste-url-magic
#  which is generally better than url-quote-magic so we load that when possible.
autoload -Uz is-at-least
if [[ ${ZSH_VERSION} != 5.1.1 && ${TERM} != "dumb" ]]; then
	if is-at-least 5.2; then
		autoload -Uz bracketed-paste-url-magic
		zle -N bracketed-paste bracketed-paste-url-magic
	else
		if is-at-least 5.1; then
			autoload -Uz bracketed-paste-magic
			zle -N bracketed-paste bracketed-paste-magic
		fi
	fi
	autoload -Uz url-quote-magic
	zle -N self-insert url-quote-magic
fi

# {{{ --- Less ---

# Preferences.
export LESSHISTFILE="$HOME/.less_history"
export LESSEDIT='vim ?lm+%lm. %f'
export LESS='-MRigSXw -z-4 --mouse --wheel-lines=3'

# Termcap.
if zstyle -t ':zmodule:environment:termcap' color; then
	export LESS_TERMCAP_mb=$'\E[01;31m'		# Begins blinking.
	export LESS_TERMCAP_md=$'\E[01;31m'		# Begins bold.
	export LESS_TERMCAP_me=$'\E[0m'			# Ends mode.
	export LESS_TERMCAP_se=$'\E[0m'			# Ends standout-mode.
	export LESS_TERMCAP_so=$'\E[00;47;30m'	# Begins standout-mode.
	export LESS_TERMCAP_ue=$'\E[0m'			# Ends underline.
	export LESS_TERMCAP_us=$'\E[01;32m'		# Begins underline.
fi

# --- End --- }}}

# {{{ --- History ---

# Preferences.
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=100000		# Maximum history events in mem
export SAVEHIST=10000000	# Maximum history file size

# History options.
setopt BANG_HIST			# Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY		# Write the history file in the ':start:elapsed;command' format.
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

# --- End --- }}}

# {{{ --- General Options ---

# Behaviour.
setopt COMBINING_CHARS		# Combine zero-length punctuation characters (accents) with the base character.
setopt INTERACTIVE_COMMENTS	# Enable comments in interactive shell.
setopt RC_QUOTES			# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING		# Don't print a warning message if a mail file has been accessed.

# Jobs.
setopt AUTO_RESUME			# Attempt to resume existing job before creating a new process.
setopt LONG_LIST_JOBS		# List jobs in the long format by default.
setopt NOTIFY				# Report status of background jobs immediately.
unsetopt BG_NICE			# Don't run all background jobs at a lower priority.
unsetopt CHECK_JOBS			# Don't report on jobs when shell exit.
unsetopt HUP				# Don't kill jobs on shell exit.

# Directory.
setopt AUTO_CD				# Auto changes to a directory without typing cd.
setopt AUTO_PUSHD			# Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS	# Do not store duplicates in the stack.
setopt PUSHD_SILENT			# Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME		# Push to home directory when no argument is given.
setopt CDABLE_VARS			# Change directory to a path stored in a variable.
setopt MULTIOS				# Write to multiple descriptors.
setopt EXTENDED_GLOB		# Use extended globbing syntax.
unsetopt CLOBBER			# Do not overwrite existing files with > and >>, use >! and >>! to bypass.

# --- End --- }}}
