#!/bin/zsh
# vim: set filetype=zsh

#PROMPT=$'%B%{\e[0;36m%}┌─[%{\e[0;33m%}%n%{\e[0;36m%}@%{\e[0;33m%}%m%{\e[0;36m%}]──(%{\e[0;33m%}%~%{\e[0;36m%})\n└─[%{\e[0;39m%}%# %{\e[0;36m%}>%b'
#PROMPT=$'%B%{\e[0;36m%}%{\e[0;33m%}%n%{\e[0;36m%}@%{\e[0;33m%}%m%{\e[0;36m%} \e[0;33m%}%~%{\e[0;36m%}\n\e[0;39m%}\e[0;36m%} >%b '

#PROMPT=$'\n\[\033[0;32m\]\u@\h \[\033[1;33m\]\w\n\[\033[0m\]> '

# Colour less && man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # Start blink text
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Start bold text
export LESS_TERMCAP_me=$'\E[0m'           # End bold text
export LESS_TERMCAP_so=$'\E[38;5;246m'    # Start text in infobox
export LESS_TERMCAP_se=$'\E[0m'           # End text in infobox
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Start of underline text
export LESS_TERMCAP_ue=$'\E[0m'           # End of underline text

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
    eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
    local PR_PROMPT='$PR_NO_COLOR➤ $PR_NO_COLOR'
elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    local PR_PROMPT='$PR_RED➤ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
    eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
fi

local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"
local user_host='${PR_USER}${PR_CYAN}@${PR_HOST}'
local current_dir='%{$PR_BOLD$PR_BLUE%}%~%{$PR_NO_COLOR%}'

PROMPT="╭─${user_host} ${current_dir}
╰─$PR_PROMPT "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_YELLOW%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$PR_NO_COLOR%}" 
