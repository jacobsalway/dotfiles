source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh

autoload -Uz compinit promptinit
compinit
promptinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh