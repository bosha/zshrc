#!/bin/zsh
# vim set filetype=zsh

ZDOTDIR=~/.zsh

# Load configuration:
for rc in $ZDOTDIR/*.sh
do
    source $rc
done
unset rc
