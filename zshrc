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

# aliases
alias g=git
alias tf=terraform

# git aliases
alias ga='git add'
alias gap='git add -p'

alias gst='git status -sb'

alias gc='git commit'
alias gcm='git commit -m'

alias gp='git push'
alias gpf='git push --force'
