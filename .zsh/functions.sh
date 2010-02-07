#!/bin/zsh
# vim: set filetype=zsh

cdls() { cd $1 && ls }

mkcd() { mkdir $1 && cd $1 }

rcd() { cd .. && rm -irfv $OLDPWD }

COPYPASTEDIR="/tmp/copypaste-$USER/"

if [ ! -d $COPYPASTEDIR ]; then
    mkdir -m 0700 $COPYPASTEDIR
fi

ccopy() {
    cp -L -a $@ $COPYPASTEDIR;
}

cmove() {
    mv $@ $COPYPASTEDIR;
}

cpaste() {
    mv $COPYPASTEDIR/* .;
}


cshow() {
    echo `ls -1 $COPYPASTEDIR | wc -l` "files in buffer:";
    ls $COPYPASTEDIR;
    echo `du -sh $COPYPASTEDIR | grep total`;
}

cclear() {
    rm $COPYPASTEDIR/*;
}


calc() {
    echo "$1" | bc
}


ompload() {
    curl -F file1=@"$1" http://omploader.org/upload|awk '/Info:|File:|Thumbnail:|BBCode:/{gsub(/<[^<]*?\/?>/,"");$1=$1;sub(/^/,"\033[0;34m");sub(/:/,"\033[0m:");print}'
}

extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "я не в курсе как распаковать '$1'..." ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
} 


pk () {
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

psu(){ command ps -Hcl -F S f -u ${1:-$USER}; } 

# Ompload       
ompload() { curl -F file1=@"$1" http://omploader.org/upload|awk '/Info:|File:|Thumbnail:|BBCode:/{gsub(/<[^<]*?\/?>/,"");$1=$1;print}';}   

# Delete dialog
function  dialogrun; {  rm -rf $(dialog --separate-output --checklist file 100  100 100 \
$(for l in $(ls -A); do echo "$l" "$(test -d $l && echo "dir" || echo "file")" 0; done) --stdout); clear  }
zle -N dialogrun
bindkey -M emacs "^X^O" dialogrun

