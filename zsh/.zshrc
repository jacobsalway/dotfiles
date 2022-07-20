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
alias tf=terraform
