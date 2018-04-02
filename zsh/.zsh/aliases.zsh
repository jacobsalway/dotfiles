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
else
    alias ls='ls -GFh --color'
    alias ll='ls -GFhl --color'
    alias la='ls -GFha --color'
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

alias youtubedl='youtube-dl -ciw -f 140 --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata -o "%(title)s.%(ext)s" -v '
