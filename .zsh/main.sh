#!/bin/zsh
# vim: set filetype=zsh

bindkey -v # vi-like bindings

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/kapsh/.zsh/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit
compinit
setopt appendhistory sharehistory autocd beep extendedglob nomatch notify

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false

zstyle ':completion:*:processes-names' command 'ps xho command'

setopt correctall
setopt noflowcontrol
