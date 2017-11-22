setopt prompt_subst

function git_prompt_info {
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}

function git_dirty {
    local FLAGS
    FLAGS=('--porcelain')
    local STATUS
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)

    if [[ -n $STATUS ]]; then
        echo "*"
    fi
}

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr 'staged '
zstyle ':vcs_info:*' unstagedstr 'unstaged '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '[%b|%a] '
zstyle ':vcs_info:*' formats \
  '%F{13}%b %F{8}%c%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='untracked'
fi
}


precmd () { vcs_info }


PROMPT='%F{8}%D{%H:%M:%S}%f [%F{5}%n%f@%F{5}%M%f] %~ ${vcs_info_msg_0_}
$ '
