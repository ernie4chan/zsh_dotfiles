# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/gpg/init.zsh
# Title: Provides an easier use of GPG.
# Maintainer: Ernie Lin
# Update:
#	20220610
#	20260512
# ---------------------------------------------------------

# Abort if gnupg is not installed/available.
(( $+commands[gpg-agent] )) || return 1

# Set paths.
_gpg_agent_conf="$HOME/.gnupg/gpg-agent.conf"
_gpg_agent_env="${XDG_CACHE_HOME:-$HOME/.cache}/gpg/gpg-agent.env"

# Load cached environment.
[[ -f "$_gpg_agent_env" ]] && source "$_gpg_agent_env" 2>/dev/null

# Resume gpg-agent if started.
[[ -S "$HOME/.gnupg/S.gpg-agent" || -S "/run/user/$(id -u)/gnupg/S.gpg-agent" ]] || {
  mkdir -p "${_gpg_agent_env:h}"
  eval "$(gpg-agent --daemon | tee "$_gpg_agent_env")"
}

# Inform gpg-agent of the current TTY for user prompts.
export GPG_TTY=$TTY

# SSH integration.
if grep -qs '^enable-ssh-support' "$_gpg_agent_conf"; then

	# Load required functions.
	autoload -Uz add-zsh-hook

	# Point SSH_AUTH_SOCK to gpg-agent's SSH socket
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

	# Load SSH module if not already loaded
	(( ! ${pmodules[(Ie)ssh]} )) && pmodload 'ssh'

	# Update GPG-Agent TTY before every command since SSH does not set it.
	function _gpg-agent-update-tty {
		gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
	}
	add-zsh-hook preexec _gpg-agent-update-tty

fi

# Disable GUI prompts over SSH.
[[ -n "$SSH_CONNECTION" ]] && export PINENTRY_USER_DATA='USE_CURSES=1'

# Cleanup.
unset _gpg_agent_{conf,env}
