# Load Powerline-status theme.
#POWERLINE_SCRIPT=${HOME}/.local/lib/powerline/bindings/zsh/powerline.zsh 
#[[ -f ${POWERLINE_SCRIPT} ]] && source ${POWERLINE_SCRIPT}

# Load Powerlevel9k theme (replacing Powerline-status).
if [[ "$TERM" == dumb ]]; then
	:
else
	POWERLEVEL_SCRIPT=${HOME}/.zsh/powerlevel9k/powerlevel9k.zsh-theme
	POWERLEVEL9K_MODE='nerdfont-complete'
	#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
	#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir rbenv vcs)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)
	[[ -f ${POWERLEVEL_SCRIPT} ]] && source ${POWERLEVEL_SCRIPT}
fi
