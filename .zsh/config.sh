#!/bin/zsh
# vim: set filetype=zsh

ZDOTDIR=~/.zsh

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Fish-like term highlighing
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

export BC_ENV_ARGS="--quiet --mathlib"

# Enable color in grep
export GREP_OPTIONS='--color=auto'
#export GREP_COLOR='3;33'

export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTIGNORE="&:ls:[bf]g:exit"

export PATH="$PATH:/home/$USER/bin" # add my bin path 
export EDITOR="/usr/bin/vim"
export PAGER='less'
export VISUAL='vim'

# I prefer english language
export LANG="en_US.UTF-8"
export LC_PAPER="ru_RU.UTF-8"
export LC_MEASUREMENT="ru_RU.UTF-8"
export LC_TIME="ru_RU.UTF-8" 
export LC_ALL="en_US.UTF-8"


# append history list to the history file;
setopt appendhistory

# import new commands from the history file also in other zsh-session
setopt sharehistory

# Remove blank lines from history
setopt hist_reduce_blanks

# Remove all duplicates from history
setopt hist_ignore_all_dups

# Avoid "beep"ing
setopt nobeep

# Extended "globbing"
setopt extended_glob

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# Add comamnds as they are typed, don't wait until shell exit
setopt inc_append_history

# report the status of backgrounds jobs immediately
setopt notify

setopt correctall

setopt noflowcontrol

# Send *not* a HUP signal to running jobs when the shell exits.
setopt nohup

# Report the status of background and suspended jobs before exiting a shell
# with job control; a second attempt to exit the shell will succeed.
setopt checkjobs

# change to directory without "cd"
setopt autocd

# display PID when suspending processes as well
setopt longlistjobs

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Ignore EOF (Ctrl-D). We set action to custom function
setopt IGNORE_EOF

# When on remote server using SSH
# imo - it's a great idea to always use tmux
if [[ -z $TMUX && -n $SSH_TTU ]]; then
    me=$(whoami)
    real_tmux=$(whence -p tmux)
    if $real_tmux has-session -t $me 2>/dev/null; then
        $real_tmux attach-session -t $me \; new-window
    else
        if [[ -n $SSH_TTY ]]; then
            echo "No tmux sessions exists. Run systemctl start tmux@$me and then tmux attach"
        fi
    fi
fi
