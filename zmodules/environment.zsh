#!/usr/bin/env zsh

#
# Shell environment variables
#

# Prompt preferences
setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents)
                            #   with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
setopt RC_QUOTES		        # Al:low 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING	      # Don't print a warning message if a mail file has been accessed.

# Jobs
setopt AUTO_RESUME          # Attempt to resume existing job before creating a new process.
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt NOTIFY				        # Report status of background jobs immediately.
unsetopt BG_NICE			      # Don't run all background jobs at a lower priority.
unsetopt CHECK_JOBS			    # Don't report on jobs when shell exit.
unsetopt HUP				        # Don't kill jobs on shell exit.

# Directory options
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>, \
                            #   use >! and >>! to bypass.

# History options
HISTFILE=$HOME/.zhistory    # The path to the history file.
HISTSIZE=10000				      # The maximum number of events to save in the internal history.
SAVEHIST=10000              # The maximum number of events to save in the history file.
setopt BANG_HIST			      # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format.
setopt HIST_BEEP            # Beep when accessing non-existent history.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS     # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY        # Share history between all sessions.

# Less options
export LESSCHARSET="UTF-8"
export LESSHISTFILE=$HOME/.less_history
export LESSEDIT='vim ?km+%lm. %f'
#export LESS='-F -g -i -M -R -S -w -X -z-4'
# '-X or --no-init'
# '-F or --quit-if-one-screen'
export LESS='-g -i -M -R -S -w -z-4'
