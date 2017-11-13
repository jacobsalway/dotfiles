# history files
if (( ! EUID )); then
    HISTFILE=$ZSH_CACHE/history_root
else
    HISTFILE=$ZSH_CACHE/history
fi

SAVEHIST=10000
HISTSIZE=12000

setopt share_history append_history extended_history hist_no_store hist_ignore_all_dups hist_ignore_space

zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history
bindkey '^X^X' hist-complete

setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NOMATCH
setopt NO_BEEP
setopt COMPLETE_IN_WORD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt no_clobber

(wal -a "78" -b "#000000" -r &)
