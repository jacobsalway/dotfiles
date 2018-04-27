export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CONFIG="$HOME/.zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE

# executable search path
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/homebrew/php/php72/bin:$PATH

# .lesshst
export LESSHISTSIZE=0
export LESSHISTFILE=/dev/null

# browser
export BROWSER=firefox
