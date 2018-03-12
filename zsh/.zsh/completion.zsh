# caching of completion stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE"

autoload -Uz compinit && compinit -d "$ZSH_CACHE/.zcompdump-$ZSH_VERSION"
