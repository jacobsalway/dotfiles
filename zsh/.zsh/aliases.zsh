export EDITOR=vim

MACHINE="$(uname -s)"

alias cl='clear'

alias aedit='$EDITOR $ZSH_CONFIG/aliases.zsh'

# git
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

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

alias jrnl=' jrnl'
