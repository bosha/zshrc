#!/bin/zsh
# vim: set filetype=zsh

ZDOTDIR=~/.zsh

export BC_ENV_ARGS="--quiet --mathlib"

export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTIGNORE="&:ls:[bf]g:exit"

export PATH="$PATH:/home/$USER/bin"
export EDITOR="/usr/bin/vim"

# type a directory's name to cd to it
compctl -/ cd

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

export LANG="en_US.UTF-8"
export LC_PAPER="ru_RU.UTF-8"
export LC_MEASUREMENT="ru_RU.UTF-8"
export LC_TIME="ru_RU.UTF-8" 
export LC_ALL="en_US.UTF-8"
