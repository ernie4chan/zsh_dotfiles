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

# {{{ --- ANSI escape code numbers: style;foreground;background ---

#   style:      0=normal  1=bold/bright
#   foreground: 30=black  31=red     32=green  33=yellow
#               34=blue   35=magenta 36=cyan   37=white
#   background: 40=black  41=red     42=green  43=yellow
#               44=blue   45=magenta 46=cyan   47=white

# }}}

# {{{ --- Re-defining 'grep' ---

# Edit to customize grep match highlight color (ANSI: text;background).
GREP_MATCH_COLOR='1;32;40'  # bright green on black — matches Andromeda's brightGreen.

zstyle -t ':e4czmod:module:utilities:grep' color && {
    if [[ "$(grep --version 2>&1)" == *GNU* ]]; then
        export GREP_COLORS="mt=${GREP_MATCH_COLOR:-$GREP_COLORS}"   # GNU 'grep'.
    else
        export GREP_COLOR="${GREP_MATCH_COLOR:-$GREP_COLOR}"        # BSD 'grep'.
    fi
    alias grep="${aliases[grep]:-grep} --color=auto"
}

unset GREP_MATCH_COLOR


# }}}

# {{{ --- Re-defining 'ls' ---

# Edit these to customize ls output colors.
GNU_LS_COLORS=(
    'di=34'         # directory — blue
    'ln=35'         # symlink — magenta
    'so=32'         # socket — green
    'pi=33'         # pipe — yellow
    'ex=31'         # executable — red
    'bd=36;01'      # block device — bold cyan
    'cd=33;01'      # char device — bold yellow
    'su=31;40;07'   # setuid — red on black, reverse
    'sg=36;40;07'   # setgid — cyan on black, reverse
    'tw=32;40;07'   # sticky+writable — green on black, reverse
    'ow=33;40;07'   # other-writable — yellow on black, reverse
)
GNU_LS_COLORS=${(j.:.)GNU_LS_COLORS}

BSD_LS_COLORS=(
    'ex'            # directory — blue
    'fx'            # symlink — magenta
    'cx'            # socket — green
    'dx'            # pipe — yellow
    'bx'            # executable — red
    'Gx'            # block device — bold cyan
    'Dx'            # char device — bold yellow
    'ab'            # setuid — red on black, reverse
    'ag'            # setgid — cyan on black, reverse
    'ac'            # sticky+writable — green on black, reverse
    'ad'            # other-writable — yellow on black, reverse
)
BSD_LS_COLORS=${(j..)BSD_LS_COLORS}

if [[ "$(ls --version 2>&1)" == *GNU* ]]; then
    # GNU 'ls'.
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
    # BSD 'ls'.
    zstyle -t ':e4czmod:module:utilities:ls' color && {
        (( ! $+LSCOLORS )) && export LSCOLORS="$BSD_LS_COLORS"
        alias ls="${aliases[ls]:-ls} -G"
    } || alias ls="${aliases[ls]:-ls} -F"
fi

unset GNU_LS_COLORS BSD_LS_COLORS

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
