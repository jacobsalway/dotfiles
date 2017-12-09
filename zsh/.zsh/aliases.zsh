export EDITOR=vim

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

alias ls='ls -GFh --color=auto'
alias ll='ls -GFhl --color=auto'
alias lsa='ls -GFha --color=auto'
alias lla='ls -GFhla --color=auto'

alias ..='cd ..; ls'
alias ...='cd ../..; ls'
alias ....='cd ../../..; ls'
alias .....='cd ../../../..; ls'

alias md='mkdir -p'
alias rd='rmdir'

alias please='sudo $(fc -ln -1)'

alias u='pacaur -Syu'
