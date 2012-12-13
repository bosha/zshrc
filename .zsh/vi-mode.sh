#!/bin/zsh
# vim: set filetype=zsh

bindkey -v # vi-like bindings

# Change cursor color basing on vi mode
zle-keymap-select () 
{
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

zle-line-finish() 
{
    if [[ $TMUX = '' ]]; then
        echo -ne "\033]12;Grey\007"
    else
        printf '\033Ptmux;\033\033]12;grey\007\033\\'
    fi
}
zle-line-init () 
{
    zle -K viins
    echo -ne "\033]12;Grey\007"
}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish
