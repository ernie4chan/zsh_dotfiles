#!/usr/bin/env zsh

#
# Prompt themes for zsh.
#

# Set default prompt to the walters theme.
#autoload -Uz promptinit
#promptinit
#prompt walters

# Load Powerline-status.
#POWERLINE_SCRIPT=$HOME/.lo:cal/lib/powerline/bindings/zsh/powerline.zsh 
#[[ -f $POWERLINE_SCRIPT ]] && source $POWERLINE_SCRIPT

# Load Powerlevel9k theme.
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)
source $HOME/.zsh/powerlevel9k/powerlevel9k.zsh-theme
