# ---------------------------------------------------------
# vim: ft=zsh
# File: ~/.zsh/modules/utilities/init.zsh
# Title: Defining Utilities
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
    lynx    "lynx -cfg=$HOME/.config/lynx/lynx.cfg"
    tree    "tree -N -L 2"
)

for cmd alias_cmd in ${(kv)cmd_aliases}; do
    if (( $+commands[$cmd] )); then
        alias "$cmd"="$alias_cmd"
    fi
done

unset cmd_aliases cmd alias_cmd

# Lists the ten most used commands.
alias keystats="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

alias diffu='diff --unified'                    # Diff in unified format.
alias fixtty='stty sane'                        # Restore terminal settings.
alias gral='alias | grep -i'                     # Search aliases.
alias myip='echo "The current IP is $(curl -s ifconfig.co)"'  # Public IP.
alias mkdir="${aliases[mkdir]:-mkdir} -p"       # Always create parent dirs.
alias ptt='ssh bbsu@ptt.cc'                     # Connect to PTT BBS.
alias po='popd'                                 # Pop directory stack.
alias pu='pushd'                                # Push directory stack.
alias 0='dirs -v'                               # List directory stack.

if (( $+commands[trash-put] )); then
    alias \
        tp='trash-put'      \
        tpl='trash-list'    \
        tpp='trash-restore' \
        tprm='trash-rm'     \
        empty='trash-empty'
fi

if (( $+commands[vim] )); then
    alias vir='vim -R'
fi

# Surfing directory on steroids.
for i ({1..9}) alias "$i"="cd +$i"
for i ({1..9}) alias ".$i"="cd ${(l:i*3::../:)}"

# }}}

# {{{ --- Source the color table ---

_zshcol_load() {
    if [[ -f ~/.zsh/zshcol ]]; then
        source ~/.zsh/zshcol
    else
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
    fi

    # Collapse — always runs after source or fallback
    local k v _gnu
    for k v in "${(kv)_GNU_LS[@]}"; do _gnu+="${k}=${v}:"; done
    typeset -g GREP_MATCH_COLOR="${_GREP[fit]}"
    typeset -g GNU_LS_COLORS="${_gnu%:}"
    typeset -g BSD_LS_COLORS="\
        ${_BSD_LS[di]}${_BSD_LS[ln]}${_BSD_LS[so]}${_BSD_LS[pi]}${_BSD_LS[ex]}\
        ${_BSD_LS[bd]}${_BSD_LS[cd]}${_BSD_LS[su]}${_BSD_LS[sg]}${_BSD_LS[tw]}\
        ${_BSD_LS[ow]}"
}

_zshcol_load
unset -f _zshcol_load

# }}}

# {{{ --- Re-defining 'grep' ---

# Edit to customize GNU or BSD 'grep' match highlight color (ANSI: text;background).
if zstyle -t ':e4czmod:module:utilities:grep' color; then
    if [[ "$(grep --version 2>&1)" == *GNU* ]]; then
        export GREP_COLORS="mt=${GREP_MATCH_COLOR:-$GREP_COLORS}"
    else
        export GREP_COLOR="${GREP_MATCH_COLOR:-$GREP_COLOR}"
    fi
    alias grep="${aliases[grep]:-grep} --color=auto"
fi

unset GREP_MATCH_COLOR

# }}}

# {{{ --- Re-defining 'ls' ---

# GNU or BSD 'ls'.
if [[ "$(ls --version 2>&1)" == *GNU* ]]; then
    if zstyle -T ':e4czmod:module:utilities:ls' dirs-first; then
        alias ls="${aliases[ls]:-ls} --group-directories-first"
    fi

    if zstyle -t ':e4czmod:module:utilities:ls' color; then
        if (( ! $+LS_COLORS )); then
            if [[ -f $HOME/.dir_colors ]]; then
                eval "$(dircolors --sh $HOME/.dir_colors)"
            else
                export LS_COLORS="$GNU_LS_COLORS"
            fi
        fi
        alias ls="${aliases[ls]:-ls} --color=auto"
    else
        alias ls="${aliases[ls]:-ls} -F"
    fi
else
    if zstyle -t ':e4czmod:module:utilities:ls' color; then
        if (( ! $+LSCOLORS )); then
            export LSCOLORS="$BSD_LS_COLORS"
        fi
        alias ls="${aliases[ls]:-ls} -G"
    else
        alias ls="${aliases[ls]:-ls} -F"
    fi
fi

unset {GNU,BSD}_LS_COLORS

alias l='ls -1F'            # One column, no hidden files.
alias ll='ls -lh'           # Human readable sizes.
alias lf='ls -1A'           # One column, hidden files.
alias la='ls -lhA'          # Human readable sizes, hidden files.
alias lr='ls -lhR'          # Human readable sizes, recursive.
alias lm='ls -lhA | "$PAGER"' # Human readable sizes, hidden files through pager.
alias lk='ls -lhSr'         # Sort by size, largest last.
alias lt='ls -lhtr'         # Sort by date, newest last.
alias lc='ls -lhtrc'        # Sort by date, shows change time.
alias lu='ls -lhtru'        # Sort by date, shows access time.

# Sort by extension (GNU only).
if [[ "$(ls --version 2>&1)" == *GNU* ]]; then
    alias lx='ls -lhXB'
fi

# }}}
