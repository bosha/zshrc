#!/bin/zsh
# vim: set filetype=zsh

bindkey -v # vi-like bindings

#ctrl-p ctrl-n history navigation
#bindkey '^P' up-history
#bindkey '^N' down-history

bindkey '^A' beginning-of-line  # Ctrl-A goto beginning of line
bindkey '^E' end-of-line # Ctrl-E goto end of line
bindkey '^K' kill-whole-line # ctrl-k
bindkey '^R' history-incremental-search-backward # ctrl-r

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# Pipe the current command through less
bindkey -s "\el" " 2>&1|less^M"
