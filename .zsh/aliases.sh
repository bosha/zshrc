#!/bin/zsh
# vim: set filetype=zsh

alias -s {avi,mpeg,mpg,mov,m2v}=smplayer
alias -s {odt,doc,sxw,rtf}=openoffice.org
alias -s {pdf,djvu}=evince
alias -s {jpg,png,svg,xpm,bmp}=gpicview

[[ -z $DISPLAY ]] && {
 alias -s {png,gif,jpg,jpeg}=fbv
 alias -s {pdf}=apvlv
} 

autoload -U pick-web-browser
alias -s {html,htm,xhtml}=pick-web-browser

if [ -f /usr/bin/grc ]; then
    alias grc='grc --colour=auto'
    alias ping='grc ping'
    alias last='grc last'
    alias netstat='grc netstat'
    alias traceroute='grc traceroute'
    alias make='grc make'
    alias gcc='grc gcc'
    alias configure='grc ./configure'
    alias cat="grc cat"
    alias tail="grc tail"
    alias head="grc head" 
fi


alias ls='ls --classify --color --human-readable --group-directories-first'
alias cp='nocorrect cp --interactive --verbose --recursive --preserve=all'
alias mv='nocorrect mv --verbose --interactive'
alias rm='nocorrect rm -Irv'
alias du='du --human-readable --total'
alias df='df --human-readable'
alias nohup='nohup > /dev/null $1'
alias s='sudo'
alias v='vim'
alias sv='sudo vim'
alias sk='sudo killall'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias k='killall' 
alias killall="killall --interactive --verbose"
alias free="free -t -m"
alias git="nocorrect git"
alias scrot="scrot --border --count --quality 75 $HOME'/screenshots/%d-%b-%y_%H-%M-%S_\$wx\$h.png' --exec 'du -h \$f'"
alias aptitude="sudo aptitude"
alias ifconfig="sudo ifconfig"
alias logo="exit"
alias ex="exit"
alias i="grep"
