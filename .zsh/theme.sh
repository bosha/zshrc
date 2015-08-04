#!/bin/zsh
# vim: set filetype=zsh

# Change cursor color basing on vi mode
zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        if [[ $TMUX = '' ]]; then
            echo -ne "\033]12;Red\007"
        else
            printf '\033Ptmux;\033\033]12;red\007\033\\'
        fi
    else
        if [[ $TMUX = '' ]]; then
            echo -ne "\033]12;Grey\007"
        else
            printf '\033Ptmux;\033\033]12;grey\007\033\\'
        fi
    fi
}

zle-line-finish() {
    if [[ $TMUX = '' ]]; then
        echo -ne "\033]12;Grey\007"
    else
        printf '\033Ptmux;\033\033]12;grey\007\033\\'
    fi
}
zle-line-init () {
    zle -K viins
    echo -ne "\033]12;Grey\007"
}

# Colour less && man pages
#export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS=-r
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
    eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
    local PR_PROMPT='$PR_NO_COLOR➤ $PR_NO_COLOR'
elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    local PR_PROMPT='$PR_RED➤ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
    eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
fi

local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"
local user_host='${PR_USER}${PR_CYAN}@${PR_HOST}'
local current_dir='%{$PR_BOLD$PR_BLUE%}%~%{$PR_NO_COLOR%}'

if [[ $(tty) == *pts* ]]; then
    export TERM="xterm-256color" # 256-colour terminal
    if [[ ! -z $TMUX ]]; then
        export TERM="screen-256color"
    else
        export TERM="xterm-256color" # 256-colour terminal
    fi
    PROMPT="╭─${user_host} ${current_dir}
╰─$PR_PROMPT "
    RPS1="${return_code}"
    zle -N zle-keymap-select
    zle -N zle-line-init
    zle -N zle-line-finish
else
    PROMPT=$'%B%{\e[0;36m%}┌─[%{\e[0;33m%}%n%{\e[0;36m%}@%{\e[0;33m%}%m%{\e[0;36m%}]──(%{\e[0;33m%}%~%{\e[0;36m%})\n└─[%{\e[0;39m%}%# %{\e[0;36m%}>%b'
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$PR_NO_COLOR%}" 
