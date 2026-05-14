# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/utilities/init.zsh
# Title: Define Utilities.
# Maintainer: Ernie Lin
# Update:
#   20250406
#   20260509
# ---------------------------------------------------------

# {{{ --- Aliases ---

# Correct commands.
if zstyle -T ':e4czmod:module:utilities' correct; then
    setopt CORRECT
fi

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias dd='nocorrect dd'
alias git='nocorrect git'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias scp='nocorrect scp'
alias ssh='nocorrect ssh'
alias sudo='nocorrect sudo'

# Disable globbing.
alias ftp='noglob ftp'
alias sftp='noglob sftp'

# Safe ops: ask the user before doing anything destructive.
if zstyle -T ':e4czmod:module:utilities' safe-ops; then
    safe_cmds=(dd cp ln mv rm shred truncate)

    for cmd in $safe_cmds; do
        alias "$cmd"="${aliases[$cmd]:-$cmd} -i"
    done

    unset safe_cmds cmd
fi

# Conditional aliases (only if command exists).
typeset -A cmd_aliases=(
    lynx  "lynx -cfg=$HOME/.config/lynx/lynx.cfg"
    tree  "tree -N -L 2"
)

for cmd alias_cmd in ${(kv)cmd_aliases}; do
    (( $+commands[$cmd] )) && alias "$cmd"="$alias_cmd"
done

unset cmd_aliases cmd alias_cmd

# Lists the ten most used commands.
alias keystats="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

alias diffu='diff --unified'                    # Diff in unified format.
alias fixtty='stty sane'                        # Restore terminal settings.
alias gra='alias | grep -i'                     # Search aliases.
alias myip='echo "The current IP is $(curl -s ifconfig.co)"'  # Public IP.
alias mkdir="${aliases[mkdir]:-mkdir} -p"       # Always create parent dirs.
alias ptt='ssh bbsu@ptt.cc'                     # Connect to PTT BBS.
alias po='popd'                                 # Pop directory stack.
alias pu='pushd'                                # Push directory stack.
alias 0='dirs -v'                               # List directory stack.

# Surfing directory on steroids.
for index in {1..9}; do
    alias "${index}"="cd +${index}"
    alias ".${index}"="cd ${(l:$index*3::../:)}"
done

unset index

# }}}

# {{{ --- Source the color table ---

_zshcolors_load() {
    [[ -f ~/.zsh/zshcolors ]] && source ~/.zsh/zshcolors || {
        # --- Re-defining 'grep' ---
        typeset -A _GREP=(
            fit  '1;32;40'
        )
        # --- Re-defining 'ls' (GNU) ---
        typeset -A _GNU_LS=(
            di  '1;34'        # directory — brightBlue    #2472C8
            ln  '1;33'        # symlink — brightYellow    #E5E512
            so  '1;32'        # socket — brightGreen      #05BC79
            pi  '1;35'        # pipe — brightPurple       #BC3FBC
            ex  '1;36'        # executable — brightCyan   #0FA8CD
            bd  '1;31'        # block device — brightRed  #CD3131
            cd  '1;35'        # char device — brightPurple #BC3FBC
            su  '1;31;40;07'  # setuid — brightRed on black, reverse
            sg  '1;36;40;07'  # setgid — brightCyan on black, reverse
            tw  '1;32;40;07'  # sticky+writable — brightGreen on black
            ow  '1;33;40;07'  # other-writable — brightYellow on black
        )
        # --- Re-defining 'ls' (BSD) ---
        typeset -A _BSD_LS=(
            di  'ex'  ln  'fx'  so  'cx'  pi  'dx'  ex  'bx'
            bd  'Gx'  cd  'Dx'  su  'ab'  sg  'ag'
            tw  'ac'  ow  'ad'
        )
    }

    # Collapse — always runs after source or fallback
    local k v _gnu
    for k v in "${(kv)_GNU_LS[@]}"; do _gnu+="${k}=${v}:"; done
    typeset -g GREP_MATCH_COLOR="${_GREP[fit]}"
    typeset -g GNU_LS_COLORS="${_gnu%:}"
    typeset -g BSD_LS_COLORS="${_BSD_LS[di]}${_BSD_LS[ln]}${_BSD_LS[so]}${_BSD_LS[pi]}${_BSD_LS[ex]}${_BSD_LS[bd]}${_BSD_LS[cd]}${_BSD_LS[su]}${_BSD_LS[sg]}${_BSD_LS[tw]}${_BSD_LS[ow]}"
}

_zshcolors_load

unset -f _zshcolors_load

# }}}

# {{{ --- Re-defining 'grep' ---

# Edit to customize grep match highlight color (ANSI: text;background).

zstyle -t ':e4czmod:module:utilities:grep' color && {
    if [[ "$(grep --version 2>&1)" == *GNU* ]]; then
        export GREP_COLORS="mt=${GREP_MATCH_COLOR:-$GREP_COLORS}"   # GNU 'grep'.
    else
        export GREP_COLOR="${GREP_MATCH_COLOR:-$GREP_COLOR}"        # BSD 'grep'.
    fi
    alias grep="${aliases[grep]:-grep} --color=auto"
}

#unset GREP_MATCH_COLOR

# }}}

# {{{ --- Re-definingza 'ls' ---

if [[ "$(ls --version 2>&1)" == *GNU* ]]; then
    # ls (GNU).
    zstyle -T ':e4czmod:module:utilities:ls' dirs-first && \
        alias ls="${aliases[ls]:-ls} --group-directories-first"
    zstyle -t ':e4czmod:module:utilities:ls' color && {
        (( ! $+LS_COLORS )) && {
            [[ -f $HOME/.dir_colors ]] \
                && eval "$(dircolors --sh $HOME/.dir_colors)" \
                || export LS_COLORS="$GNU_LS_COLORS"
        }
        alias ls="${aliases[ls]:-ls} --color=auto"
    } || alias ls="${aliases[ls]:-ls} -F"
else
    # ls (BSD).
    zstyle -t ':e4czmod:module:utilities:ls' color && {
        (( ! $+LSCOLORS )) && export LSCOLORS="$BSD_LS_COLORS"
        alias ls="${aliases[ls]:-ls} -G"
    } || alias ls="${aliases[ls]:-ls} -F"
fi

#unset GNU_LS_COLORS BSD_LS_COLORS

alias l='ls -1F'            # One column, no hidden files.
alias ll='ls -lh'           # Human readable sizes.
alias la='ll -A'            # Human readable sizes, hidden files.
alias lr='ll -R'            # Human readable sizes, recursive.
alias lm='ll -A | "$PAGER"' # Human readable sizes, hidden files through pager.
alias lk='ll -Sr'           # Sort by size, largest last.
alias lt='ll -tr'           # Sort by date, newest last.
alias lc='ll -trc'          # Sort by date, shows change time.
alias lu='ll -tru'          # Sort by date, shows access time.

# Sort by extension (GNU only).
[[ "$(ls --version 2>&1)" == *GNU* ]] && alias lx='ll -XB'

# }}}
