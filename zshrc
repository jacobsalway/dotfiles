PROMPT='%F{14}%n%f %F{241}[%f%~%F{241}]%f
$ '

# keep command history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# enable vim mode
bindkey -v
bindkey '^R' history-incremental-search-backward

# cd setopts
setopt nocaseglob
setopt correct
setopt auto_cd

# cd aliases
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

take() {
    mkdir -p "$1" && cd "$1"
}

r() {
    cd "$(git rev-parse --show-toplevel 2>/dev/null)"
}
