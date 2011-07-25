#!/bin/zsh
# vim set filetype=zsh

ZDOTDIR=~/.zsh

# Execute ~/.profile:
#source ~/.profile

# Load configuration:
for rc in $ZDOTDIR/*.sh
do
    source $rc
done
unset rc
