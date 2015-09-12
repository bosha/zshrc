#!/bin/zsh
# vim: set filetype=zsh

function preexec {
    case $TERM in
    xterm*)
        print -Pn "\e]0;$1\a"
        ;;
    screen)
        #PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
        ;;
    *)
        PR_TITLEBAR=''
        ;;
    esac
}

extract () {
    echo Extracting $1 ...
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tbz)       tar -xjvf $1    ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "I don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
} 

pk () {
    echo "Archiving $1 ..."
    if [ $1 ] ; then
        case $1 in
            tbz)       tar cjvf $2.tar.bz2 $2      ;;
            tgz)       tar czvf $2.tar.gz  $2       ;;
            tar)      tar cpvf $2.tar  $2       ;;
            bz2)    bzip $2 ;;
            gz)        gzip -c -9 -n $2 > $2.gz ;;
            zip)       zip -r $2.zip $2   ;;
            7z)        7z a $2.7z $2    ;;
            *)         echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


custom_exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        real_tmux=$(whence -p tmux)
        count=$($real_tmux list-windows &> /dev/null | wc -l)
        if [ $count -gt 1 ]; then
            builtin exit
        else
            $real_tmux detach
        fi
    fi
}
zle -N custom_exit

tmux_run() {
    me=$(whoami)
    real_tmux=$(whence -p tmux)
    args_num="$#"

    if [ "$#" -gt 0 ]; then
        TERM=screen-256color $real_tmux "$*"
    else
        if [[ ! -z $TMUX ]]; then
            TERM=screen-256color $real_tmux
        else
            if $real_tmux has-session -t $me 2>/dev/null; then
                TERM=screen-256color $real_tmux attach-session -t $me
            else
                TERM=screen-256color $real_tmux new -s $USER
                TERM=screen-256color $real_tmux attach-session -t $me
            fi
        fi
    fi
}
