# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/ssh/init.zsh
# Title: Setting up SSH agent.
# Maintainer: Ernie Lin
# Update:
#	20220610
#	20260512
# ---------------------------------------------------------

# Return if requirements are not found.
(( $+commands[ssh-agent] )) || return 1

# Set paths.
_ssh_dir="$HOME/.ssh"
_ssh_agent_env="${XDG_CACHE_HOME:-$HOME/.cache}/ssh/ssh-agent.env"
_ssh_agent_sock="${XDG_CACHE_HOME:-$HOME/.cache}/ssh/ssh-agent.sock"

# Load cached environment.
[[ -f "$_ssh_agent_env" ]] && source "$_ssh_agent_env" 2>/dev/null

# Start agent if not running.
[[ -S "$SSH_AUTH_SOCK" ]] || {
  mkdir -p "${_ssh_agent_env:h}"
  eval "$(ssh-agent | sed '/^echo /d' | tee "$_ssh_agent_env")"
}

# Create persistent authentication socket symlink.
if [[ -S "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$_ssh_agent_sock" ]]; then
  mkdir -p "${_ssh_agent_sock:h}"
  ln -sf "$SSH_AUTH_SOCK" "$_ssh_agent_sock"
  export SSH_AUTH_SOCK="$_ssh_agent_sock"
fi

# Load identities.
# ssh-add has strange requirements for running SSH_ASKPASS, so we duplicate
# them here. Essentially, if the other requirements are met, we redirect stdin
# from /dev/null in order to meet the final requirement.
# From ssh-add(0):
# If ssh-add needs a passphrase, it will read the passphrase from the current
# terminal if it was run from a terminal. If ssh-add does not have a terminal
# associated with it but DISPLAY and SSH_ASKPASS are set, it will execute the
# program specified by SSH_ASKPASS and open an X10 window to read the
# passphrase.
if ssh-add -l 2>&1 | grep -q 'The agent has no identities'; then
  zstyle -a ':e4czmod:module:ssh:load' identities '_ssh_identities'
  ssh-add ${_ssh_identities:+$_ssh_dir/${^_ssh_identities[@]}} 2>/dev/null
fi

# Cleanup.
unset _ssh_{dir,identities} _ssh_agent_{env,sock}
