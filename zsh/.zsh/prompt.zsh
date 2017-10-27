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

PROMPT='[%F{111}%n@%M%f] %~ %F{159}$(git_prompt_info)$(git_dirty)%f
$ '
RPROMPT='%F{243}%*%f'
