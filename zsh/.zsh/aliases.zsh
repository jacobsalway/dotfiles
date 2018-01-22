export EDITOR=vim

MACHINE="$(uname -s)"

alias cl='clear'

alias aedit='$EDITOR $ZSH_CONFIG/aliases.zsh'

alias ~='cd ~'
alias /='cd /'

if [[ $MACHINE == "Darwin" ]]; then
    alias ls='ls -GFh'
    alias ll='ls -GFhl'
    alias lsa='ls -GFha'
    alias lla='ls -GFhla'
else
    alias ls='ls -GFh --color'
    alias ll='ls -GFhl --color'
    alias lsa='ls -GFha --color'
    alias lla='ls -GFhla --color'
fi

alias ..='cd ..; ls'
alias ...='cd ../..; ls'
alias ....='cd ../../..; ls'
alias .....='cd ../../../..; ls'

alias md='mkdir -p'
alias rd='rmdir'

alias please='sudo $(fc -ln -1)'

alias u='trizen -Syu'
