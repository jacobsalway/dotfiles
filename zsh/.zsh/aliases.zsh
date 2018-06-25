source $ZSH_CONFIG/git-aliases.zsh

export EDITOR=vim

MACHINE="$(uname -s)"

alias cl='clear'

alias aedit='$EDITOR $ZSH_CONFIG/aliases.zsh'

alias ~='cd ~'
alias /='cd /'

if [[ $MACHINE == "Darwin" ]]; then
    alias ls='ls -GFh'
    alias ll='ls -GFhl'
    alias la='ls -GFha'
    alias lla='ls -GFhla'
    alias lsa='LS -GFha'
else
    alias ls='ls -GFh'
    alias ll='ls -GFhl'
    alias la='ls -GFha'
    alias lla='ls -GFhla'
    alias lsa='ls -GFha'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias md='mkdir -p'
alias rd='rmdir'

alias please='sudo $(fc -ln -1)'

alias u='trizen -Syu'
