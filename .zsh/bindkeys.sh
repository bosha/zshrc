#!/bin/zsh
# vim: set filetype=zsh

#ctrl-p ctrl-n history navigation
#bindkey '^P' up-history
#bindkey '^N' down-history

bindkey '^A' beginning-of-line  # Ctrl-A goto beginning of line
bindkey '^E' end-of-line # Ctrl-E goto end of line
bindkey '^K' kill-whole-line # ctrl-k
bindkey '^R' history-incremental-search-backward # ctrl-r
